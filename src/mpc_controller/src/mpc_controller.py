#!/usr/bin/env python
#
# Copyright (c) 2018-2020 Intel Corporation
#
# This work is licensed under the terms of the MIT license.
# For a copy, see <https://opensource.org/licenses/MIT>.
#
"""
Todo:
    - Extract vehicle state information and print (done)
    - Convert the global path into frenet frame 
    - Convert the pose data into frenet frame
    - Pass vehicle state information to the MPC controller
    - Implement the border_cb function
    - Implement the border publishing node

"""

import collections
import math
import threading

import ros_compatibility as roscomp
from ros_compatibility.node import CompatibleNode
from ros_compatibility.qos import QoSProfile, DurabilityPolicy
from tf.transformations import euler_from_quaternion, quaternion_from_euler

# from carla_ad_agent.vehicle_mpc_controller import VehicleMPCController
from carla_ad_agent.misc import distance_vehicle

from carla_msgs.msg import CarlaEgoVehicleControl, CarlaEgoVehicleStatus  # pylint: disable=import-error
from nav_msgs.msg import Odometry, Path
from geometry_msgs.msg import Pose, PoseStamped
from std_msgs.msg import Float64
from visualization_msgs.msg import Marker

from global_planner.srv import Frenet2WorldService, World2FrenetService
from global_planner.msg import FrenetPose, WorldPose

class LocalPlannerMPC(CompatibleNode):
    """
    LocalPlanner implements the basic behavior of following a trajectory of waypoints that is
    generated on-the-fly. The low-level motion of the vehicle is computed by using two PID
    controllers, one is used for the lateral control and the other for the longitudinal
    control (cruise speed).

    When multiple paths are available (intersections) this local planner makes a random choice.
    """

    # minimum distance to target waypoint as a percentage (e.g. within 90% of
    # total distance)
    MIN_DISTANCE_PERCENTAGE = 0.9

    def __init__(self):
        super(LocalPlannerMPC, self).__init__("local_planner_mpc")

        role_name = self.get_param("role_name", "ego_vehicle")
        self.control_time_step = self.get_param("control_time_step", 0.05)

        # Fetch the Q and R matrices from parameters
        self.Q_matrix = self.get_param('~Q_matrix', [[1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [0.0, 0.0, 1.0]])  # Default Q matrix if not set
        self.R_matrix = self.get_param('~R_matrix', [[1.0, 0.0], [0.0, 1.0]])  # Default R matrix if not set
        
        # Log the matrices for verification
        # self.loginfo("Q matrix: %s", str(self.Q_matrix))
        # self.loginfo("R matrix: %s", str(self.R_matrix))
        self.data_lock = threading.Lock()

        self._current_pose = None
        self._current_speed = None
        self._current_velocity = None
        self._target_speed = 0.0
        self._current_accel = None
        self._current_throttle = None
        self._current_brake = None
        self._current_steering = None

        self._buffer_size = 5
        self._waypoints_queue = collections.deque(maxlen=20000)
        self._waypoint_buffer = collections.deque(maxlen=self._buffer_size)

        # subscribers
        self._odometry_subscriber = self.new_subscription(
            Odometry,
            "/carla/{}/odometry".format(role_name),
            self.odometry_cb,
            qos_profile=10)
        self._ego_status_subscriber = self.new_subscription(
            CarlaEgoVehicleStatus,
            "/carla/{}/vehicle_status".format(role_name),
            self.ego_status_cb,
            qos_profile=10)
        self._path_subscriber = self.new_subscription(
            Path,
            "/carla/{}/waypoints".format(role_name),
            self.path_cb,
            QoSProfile(depth=1, durability=DurabilityPolicy.TRANSIENT_LOCAL))
        
        self._world2frenet_service = self.new_client(
            World2FrenetService,
            '/world2frenet')
        self._frenet2world_service = self.new_client(
            Frenet2WorldService,
            '/frenet2world')      

        ## Todo: Implement later ##
        self._border_subscriber = self.new_subscription(
            Path,
            "/carla/{}/border_waypoints".format(role_name),
            self.border_cb,
            QoSProfile(depth=1, durability=DurabilityPolicy.TRANSIENT_LOCAL))
        ## Todo: Implement later ##


        self._target_speed_subscriber = self.new_subscription(
            Float64,
            "/carla/{}/speed_command".format(role_name),
            self.target_speed_cb,
            QoSProfile(depth=1, durability=DurabilityPolicy.TRANSIENT_LOCAL))




        # publishers
        self._target_pose_publisher = self.new_publisher(
            Marker,
            "/mpc_controller/{}/next_target".format(role_name),
            qos_profile=10)
        self._control_cmd_publisher = self.new_publisher(
            CarlaEgoVehicleControl,
            "/mpc_controller/{}/vehicle_control_cmd".format(role_name),
            qos_profile=10)
        
        self._reference_path_publisher = self.new_publisher(
            Path,
            "/mpc_controller/{}/reference_path".format(role_name),
            qos_profile=10)

        # initializing controller
        # self._vehicle_controller = VehicleMPCController(
        #     self)

    def odometry_cb(self, odometry_msg):
        # self.loginfo("Received odometry message")
        with self.data_lock:
            self._current_pose = odometry_msg.pose.pose
            self._current_speed = math.sqrt(odometry_msg.twist.twist.linear.x ** 2 +
                                            odometry_msg.twist.twist.linear.y ** 2 +
                                            odometry_msg.twist.twist.linear.z ** 2) * 3.6 # m/s to km/h
            self._draw_reference_point(self._current_pose)

    def _draw_reference_point(self, pose):
        ref_path = Path()
        ref_path.header.frame_id = "map"
        ref_path.header.stamp = roscomp.ros_timestamp(self.get_time(), from_sec=True)


        frenet_pose = self._get_frenet_pose(pose)
        # self.loginfo("Frenet pose: {}".format(frenet_pose))
        s, d = frenet_pose.s, frenet_pose.d
        # 10 waypoints 10m ahead of the vehicle: 
            # todo: make sure the waypoints are within the length of the path
        for i in range(10):
            request = FrenetPose()
            request.s = s + i * 0.5
            request.d = 0
            request.yaw_s = 0
            response = self._frenet2world_service(request)
            pose_msg = self._world2pose(response)
            pose_stamped = PoseStamped()
            pose_stamped.pose = pose_msg
            ref_path.poses.append(pose_stamped)

        self._reference_path_publisher.publish(ref_path)
    # converts WorldPose to geometry_msgs/Pose
    def _world2pose(self, world_pose):
        world_pose = world_pose.world_pose
        pose = Pose()
        pose.position.x = world_pose.x
        pose.position.y = world_pose.y
        pose.position.z = 0
        yaw = world_pose.yaw
        # self.loginfo("Test _worl2pose Yaw: {}".format(yaw))
        pose.orientation.x, pose.orientation.y, pose.orientation.z, pose.orientation.w = quaternion_from_euler(0, 0, yaw)
        # pose.orientation.x = 0
        # pose.orientation.y = 0
        # pose.orientation.z = 0
        # pose.orientation.w = 1
        return pose

    def _get_world_pose(self, frenet_pose):
        request = FrenetPose()
        request.s = frenet_pose.s
        request.d = frenet_pose.d
        response = self._frenet2world_service(request)
        return response.pose
    
    def _get_frenet_pose(self, pose):
        request = WorldPose()
        request.x = pose.position.x
        request.y = pose.position.y
        _, _, yaw = euler_from_quaternion([pose.orientation.x, pose.orientation.y, 
                                            pose.orientation.z, pose.orientation.w])
        request.yaw = yaw
        # request.v = self._current_speed
        # request.acc = self._current_accel
        # request.target_v = self._target_speed

        response = self._world2frenet_service(request)
        # self.loginfo("Test _get_frenet_pose: {}".format(response))
        return response.frenet_pose

    def ego_status_cb(self, ego_status_msg):
        with self.data_lock:
            self._current_accel = math.sqrt(ego_status_msg.acceleration.linear.x ** 2 +
                                            ego_status_msg.acceleration.linear.y ** 2 +
                                            ego_status_msg.acceleration.linear.z ** 2) * 3.6
            self._current_throttle = ego_status_msg.control.throttle
            self._current_brake = ego_status_msg.control.brake
            self._current_steering = ego_status_msg.control.steer
            self._current_velocity = ego_status_msg.velocity
        ## Todo: Check if 3.6 is the correct conversion factor ##         



    def target_speed_cb(self, target_speed_msg):
        with self.data_lock:
            self._target_speed = target_speed_msg.data

    def path_cb(self, path_msg):
        with self.data_lock:
            self._waypoint_buffer.clear()
            self._waypoints_queue.clear()
            self._waypoints_queue.extend([pose.pose for pose in path_msg.poses])
            # self.loginfo("Received path message of length: {}".format(len(path_msg)))
            self.loginfo("Current waypoints queue length: {}".format(len(self._waypoints_queue)))
            self.loginfo("Current waypoints buffer length: {}".format(len(self._waypoint_buffer)))
            # self.loginfo("First waypoint in queue: {}".format(self._waypoints_queue[0]))

    ## Todo: Write border publishing node and implement this function ##
    def border_cb(self, path_msg):
        pass
        with self.data_lock:
            self._waypoint_buffer.clear()
            self._waypoints_queue.clear()
            self._waypoints_queue.extend([pose.pose for pose in path_msg.poses])
    ##  -------------------------------------------------------------- ##

    def pose_to_marker_msg(self, pose):
        marker_msg = Marker()
        marker_msg.type = 0
        marker_msg.header.frame_id = "map"
        marker_msg.pose = pose
        marker_msg.scale.x = 1.0
        marker_msg.scale.y = 0.2
        marker_msg.scale.z = 0.2
        marker_msg.color.r = 255.0
        marker_msg.color.a = 1.0
        return marker_msg

    def run_step(self):
        """
        Sets up the OCP problem in acados and solves it
         - initializes the acados 
         - print:
            - current cartesian state (pose+velocity)
            - current frenet state (s, d, yaw_s + frenet velocity, acceleration)
            - current vehicle actuators (throttle, brake, steering)

        """
        with self.data_lock:
            # debug info
            self.loginfo("Current speed: {}".format(self._current_speed))
            self.loginfo("Current pose: {}".format(self._current_pose)) 
            self.loginfo("Current velocity: {}".format(self._current_velocity))
            self.loginfo("Target speed: {}".format(self._target_speed))
            self.loginfo("Current throttle: {}".format(self._current_throttle))
            self.loginfo("Current brake: {}".format(self._current_brake))
            self.loginfo("Current steering: {}".format(self._current_steering))
            self.loginfo("Current acceleration: {}".format(self._current_accel))

            # initiailize the acados problem
            # self._acados_init()
            # setup ocp
            # self._setup_ocp(
            # solve ocp

            # get solution

            # update initial condition

            # draw computed trajectory

            return

            # 



            
            # if not self._waypoint_buffer and not self._waypoints_queue:
            #     self.loginfo("Waiting for a route...")
            #     self.emergency_stop()
            #     return

            # # when target speed is 0, brake.
            # if self._target_speed == 0.0:
            #     self.emergency_stop()
            #     return

            # #   Buffering the waypoints
            # if not self._waypoint_buffer:
            #     for i in range(self._buffer_size):
            #         if self._waypoints_queue:
            #             self._waypoint_buffer.append(self._waypoints_queue.popleft())
            #         else:
            #             break

            # # target waypoint
            # target_pose = self._waypoint_buffer[0]
            # self._target_pose_publisher.publish(self.pose_to_marker_msg(target_pose))

            # # move using PID controllers
            # control_msg = self._vehicle_controller.run_step(
            #     self._target_speed, self._current_speed, self._current_pose, target_pose)

            # # purge the queue of obsolete waypoints
            # max_index = -1

            # sampling_radius = self._target_speed * 1 / 3.6  # search radius for next waypoints in seconds
            # min_distance = sampling_radius * self.MIN_DISTANCE_PERCENTAGE

            # for i, route_point in enumerate(self._waypoint_buffer):
            #     if distance_vehicle(route_point, self._current_pose.position) < min_distance:
            #         max_index = i
            # if max_index >= 0:
            #     for i in range(max_index + 1):
            #         self._waypoint_buffer.popleft()

            # self._control_cmd_publisher.publish(control_msg)

    def emergency_stop(self):
        control_msg = CarlaEgoVehicleControl()
        control_msg.steer = 0.0
        control_msg.throttle = 0.0
        control_msg.brake = 1.0
        control_msg.hand_brake = False
        control_msg.manual_gear_shift = False
        self._control_cmd_publisher.publish(control_msg)


def main(args=None):
    """

    main function

    :return:
    """
    roscomp.init("local_planner_mpc", args=args)

    local_planner_mpc = None
    update_timer = None
    try:
        local_planner_mpc = LocalPlannerMPC()
        roscomp.on_shutdown(local_planner_mpc.emergency_stop)

        update_timer = local_planner_mpc.new_timer(
            local_planner_mpc.control_time_step, lambda timer_event=None: local_planner_mpc.run_step())

        local_planner_mpc.spin()

    except KeyboardInterrupt:
        pass

    finally:
        roscomp.loginfo('Local planner shutting down.')
        roscomp.shutdown()

if __name__ == "__main__":
    main()
