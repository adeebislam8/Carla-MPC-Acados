; Auto-generated. Do not edit!


(cl:in-package global_planner-srv)


;//! \htmlinclude World2FrenetService-request.msg.html

(cl:defclass <World2FrenetService-request> (roslisp-msg-protocol:ros-message)
  ((world_pose
    :reader world_pose
    :initarg :world_pose
    :type global_planner-msg:WorldPose
    :initform (cl:make-instance 'global_planner-msg:WorldPose)))
)

(cl:defclass World2FrenetService-request (<World2FrenetService-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <World2FrenetService-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'World2FrenetService-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name global_planner-srv:<World2FrenetService-request> is deprecated: use global_planner-srv:World2FrenetService-request instead.")))

(cl:ensure-generic-function 'world_pose-val :lambda-list '(m))
(cl:defmethod world_pose-val ((m <World2FrenetService-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader global_planner-srv:world_pose-val is deprecated.  Use global_planner-srv:world_pose instead.")
  (world_pose m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <World2FrenetService-request>) ostream)
  "Serializes a message object of type '<World2FrenetService-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'world_pose) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <World2FrenetService-request>) istream)
  "Deserializes a message object of type '<World2FrenetService-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'world_pose) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<World2FrenetService-request>)))
  "Returns string type for a service object of type '<World2FrenetService-request>"
  "global_planner/World2FrenetServiceRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'World2FrenetService-request)))
  "Returns string type for a service object of type 'World2FrenetService-request"
  "global_planner/World2FrenetServiceRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<World2FrenetService-request>)))
  "Returns md5sum for a message object of type '<World2FrenetService-request>"
  "530f2b7503e3482b362b155805927d68")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'World2FrenetService-request)))
  "Returns md5sum for a message object of type 'World2FrenetService-request"
  "530f2b7503e3482b362b155805927d68")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<World2FrenetService-request>)))
  "Returns full string definition for message of type '<World2FrenetService-request>"
  (cl:format cl:nil "WorldPose world_pose~%~%================================================================================~%MSG: global_planner/WorldPose~%float64 x~%float64 y~%float64 yaw~%float64 v~%float64 acc~%float64 target_v~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'World2FrenetService-request)))
  "Returns full string definition for message of type 'World2FrenetService-request"
  (cl:format cl:nil "WorldPose world_pose~%~%================================================================================~%MSG: global_planner/WorldPose~%float64 x~%float64 y~%float64 yaw~%float64 v~%float64 acc~%float64 target_v~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <World2FrenetService-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'world_pose))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <World2FrenetService-request>))
  "Converts a ROS message object to a list"
  (cl:list 'World2FrenetService-request
    (cl:cons ':world_pose (world_pose msg))
))
;//! \htmlinclude World2FrenetService-response.msg.html

(cl:defclass <World2FrenetService-response> (roslisp-msg-protocol:ros-message)
  ((frenet_pose
    :reader frenet_pose
    :initarg :frenet_pose
    :type global_planner-msg:FrenetPose
    :initform (cl:make-instance 'global_planner-msg:FrenetPose)))
)

(cl:defclass World2FrenetService-response (<World2FrenetService-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <World2FrenetService-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'World2FrenetService-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name global_planner-srv:<World2FrenetService-response> is deprecated: use global_planner-srv:World2FrenetService-response instead.")))

(cl:ensure-generic-function 'frenet_pose-val :lambda-list '(m))
(cl:defmethod frenet_pose-val ((m <World2FrenetService-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader global_planner-srv:frenet_pose-val is deprecated.  Use global_planner-srv:frenet_pose instead.")
  (frenet_pose m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <World2FrenetService-response>) ostream)
  "Serializes a message object of type '<World2FrenetService-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'frenet_pose) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <World2FrenetService-response>) istream)
  "Deserializes a message object of type '<World2FrenetService-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'frenet_pose) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<World2FrenetService-response>)))
  "Returns string type for a service object of type '<World2FrenetService-response>"
  "global_planner/World2FrenetServiceResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'World2FrenetService-response)))
  "Returns string type for a service object of type 'World2FrenetService-response"
  "global_planner/World2FrenetServiceResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<World2FrenetService-response>)))
  "Returns md5sum for a message object of type '<World2FrenetService-response>"
  "530f2b7503e3482b362b155805927d68")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'World2FrenetService-response)))
  "Returns md5sum for a message object of type 'World2FrenetService-response"
  "530f2b7503e3482b362b155805927d68")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<World2FrenetService-response>)))
  "Returns full string definition for message of type '<World2FrenetService-response>"
  (cl:format cl:nil "FrenetPose frenet_pose~%~%================================================================================~%MSG: global_planner/FrenetPose~%float64 s~%float64 s_dot~%float64 s_ddot~%float64 d~%float64 d_dot~%float64 d_ddot~%float64 yaw_s~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'World2FrenetService-response)))
  "Returns full string definition for message of type 'World2FrenetService-response"
  (cl:format cl:nil "FrenetPose frenet_pose~%~%================================================================================~%MSG: global_planner/FrenetPose~%float64 s~%float64 s_dot~%float64 s_ddot~%float64 d~%float64 d_dot~%float64 d_ddot~%float64 yaw_s~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <World2FrenetService-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'frenet_pose))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <World2FrenetService-response>))
  "Converts a ROS message object to a list"
  (cl:list 'World2FrenetService-response
    (cl:cons ':frenet_pose (frenet_pose msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'World2FrenetService)))
  'World2FrenetService-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'World2FrenetService)))
  'World2FrenetService-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'World2FrenetService)))
  "Returns string type for a service object of type '<World2FrenetService>"
  "global_planner/World2FrenetService")