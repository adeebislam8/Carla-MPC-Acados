;; Auto-generated. Do not edit!


(when (boundp 'global_planner::World2FrenetService)
  (if (not (find-package "GLOBAL_PLANNER"))
    (make-package "GLOBAL_PLANNER"))
  (shadow 'World2FrenetService (find-package "GLOBAL_PLANNER")))
(unless (find-package "GLOBAL_PLANNER::WORLD2FRENETSERVICE")
  (make-package "GLOBAL_PLANNER::WORLD2FRENETSERVICE"))
(unless (find-package "GLOBAL_PLANNER::WORLD2FRENETSERVICEREQUEST")
  (make-package "GLOBAL_PLANNER::WORLD2FRENETSERVICEREQUEST"))
(unless (find-package "GLOBAL_PLANNER::WORLD2FRENETSERVICERESPONSE")
  (make-package "GLOBAL_PLANNER::WORLD2FRENETSERVICERESPONSE"))

(in-package "ROS")





(defclass global_planner::World2FrenetServiceRequest
  :super ros::object
  :slots (_world_pose ))

(defmethod global_planner::World2FrenetServiceRequest
  (:init
   (&key
    ((:world_pose __world_pose) (instance global_planner::WorldPose :init))
    )
   (send-super :init)
   (setq _world_pose __world_pose)
   self)
  (:world_pose
   (&rest __world_pose)
   (if (keywordp (car __world_pose))
       (send* _world_pose __world_pose)
     (progn
       (if __world_pose (setq _world_pose (car __world_pose)))
       _world_pose)))
  (:serialization-length
   ()
   (+
    ;; global_planner/WorldPose _world_pose
    (send _world_pose :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; global_planner/WorldPose _world_pose
       (send _world_pose :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; global_planner/WorldPose _world_pose
     (send _world_pose :deserialize buf ptr-) (incf ptr- (send _world_pose :serialization-length))
   ;;
   self)
  )

(defclass global_planner::World2FrenetServiceResponse
  :super ros::object
  :slots (_frenet_pose ))

(defmethod global_planner::World2FrenetServiceResponse
  (:init
   (&key
    ((:frenet_pose __frenet_pose) (instance global_planner::FrenetPose :init))
    )
   (send-super :init)
   (setq _frenet_pose __frenet_pose)
   self)
  (:frenet_pose
   (&rest __frenet_pose)
   (if (keywordp (car __frenet_pose))
       (send* _frenet_pose __frenet_pose)
     (progn
       (if __frenet_pose (setq _frenet_pose (car __frenet_pose)))
       _frenet_pose)))
  (:serialization-length
   ()
   (+
    ;; global_planner/FrenetPose _frenet_pose
    (send _frenet_pose :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; global_planner/FrenetPose _frenet_pose
       (send _frenet_pose :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; global_planner/FrenetPose _frenet_pose
     (send _frenet_pose :deserialize buf ptr-) (incf ptr- (send _frenet_pose :serialization-length))
   ;;
   self)
  )

(defclass global_planner::World2FrenetService
  :super ros::object
  :slots ())

(setf (get global_planner::World2FrenetService :md5sum-) "530f2b7503e3482b362b155805927d68")
(setf (get global_planner::World2FrenetService :datatype-) "global_planner/World2FrenetService")
(setf (get global_planner::World2FrenetService :request) global_planner::World2FrenetServiceRequest)
(setf (get global_planner::World2FrenetService :response) global_planner::World2FrenetServiceResponse)

(defmethod global_planner::World2FrenetServiceRequest
  (:response () (instance global_planner::World2FrenetServiceResponse :init)))

(setf (get global_planner::World2FrenetServiceRequest :md5sum-) "530f2b7503e3482b362b155805927d68")
(setf (get global_planner::World2FrenetServiceRequest :datatype-) "global_planner/World2FrenetServiceRequest")
(setf (get global_planner::World2FrenetServiceRequest :definition-)
      "WorldPose world_pose

================================================================================
MSG: global_planner/WorldPose
float64 x
float64 y
float64 yaw
float64 v
float64 acc
---
FrenetPose frenet_pose

================================================================================
MSG: global_planner/FrenetPose
float64 s
float64 s_dot
float64 s_ddot
float64 d
float64 d_dot
float64 d_ddot
")

(setf (get global_planner::World2FrenetServiceResponse :md5sum-) "530f2b7503e3482b362b155805927d68")
(setf (get global_planner::World2FrenetServiceResponse :datatype-) "global_planner/World2FrenetServiceResponse")
(setf (get global_planner::World2FrenetServiceResponse :definition-)
      "WorldPose world_pose

================================================================================
MSG: global_planner/WorldPose
float64 x
float64 y
float64 yaw
float64 v
float64 acc
---
FrenetPose frenet_pose

================================================================================
MSG: global_planner/FrenetPose
float64 s
float64 s_dot
float64 s_ddot
float64 d
float64 d_dot
float64 d_ddot
")



(provide :global_planner/World2FrenetService "530f2b7503e3482b362b155805927d68")


