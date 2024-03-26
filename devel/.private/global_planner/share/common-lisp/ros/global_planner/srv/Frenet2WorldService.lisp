; Auto-generated. Do not edit!


(cl:in-package global_planner-srv)


;//! \htmlinclude Frenet2WorldService-request.msg.html

(cl:defclass <Frenet2WorldService-request> (roslisp-msg-protocol:ros-message)
  ((frenet_pose
    :reader frenet_pose
    :initarg :frenet_pose
    :type global_planner-msg:FrenetPose
    :initform (cl:make-instance 'global_planner-msg:FrenetPose)))
)

(cl:defclass Frenet2WorldService-request (<Frenet2WorldService-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Frenet2WorldService-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Frenet2WorldService-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name global_planner-srv:<Frenet2WorldService-request> is deprecated: use global_planner-srv:Frenet2WorldService-request instead.")))

(cl:ensure-generic-function 'frenet_pose-val :lambda-list '(m))
(cl:defmethod frenet_pose-val ((m <Frenet2WorldService-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader global_planner-srv:frenet_pose-val is deprecated.  Use global_planner-srv:frenet_pose instead.")
  (frenet_pose m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Frenet2WorldService-request>) ostream)
  "Serializes a message object of type '<Frenet2WorldService-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'frenet_pose) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Frenet2WorldService-request>) istream)
  "Deserializes a message object of type '<Frenet2WorldService-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'frenet_pose) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Frenet2WorldService-request>)))
  "Returns string type for a service object of type '<Frenet2WorldService-request>"
  "global_planner/Frenet2WorldServiceRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Frenet2WorldService-request)))
  "Returns string type for a service object of type 'Frenet2WorldService-request"
  "global_planner/Frenet2WorldServiceRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Frenet2WorldService-request>)))
  "Returns md5sum for a message object of type '<Frenet2WorldService-request>"
  "7c3d04499a34679df3b3eaae1ccad4b8")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Frenet2WorldService-request)))
  "Returns md5sum for a message object of type 'Frenet2WorldService-request"
  "7c3d04499a34679df3b3eaae1ccad4b8")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Frenet2WorldService-request>)))
  "Returns full string definition for message of type '<Frenet2WorldService-request>"
  (cl:format cl:nil "FrenetPose frenet_pose~%~%================================================================================~%MSG: global_planner/FrenetPose~%float64 s~%float64 s_dot~%float64 s_ddot~%float64 d~%float64 d_dot~%float64 d_ddot~%float64 yaw_s~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Frenet2WorldService-request)))
  "Returns full string definition for message of type 'Frenet2WorldService-request"
  (cl:format cl:nil "FrenetPose frenet_pose~%~%================================================================================~%MSG: global_planner/FrenetPose~%float64 s~%float64 s_dot~%float64 s_ddot~%float64 d~%float64 d_dot~%float64 d_ddot~%float64 yaw_s~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Frenet2WorldService-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'frenet_pose))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Frenet2WorldService-request>))
  "Converts a ROS message object to a list"
  (cl:list 'Frenet2WorldService-request
    (cl:cons ':frenet_pose (frenet_pose msg))
))
;//! \htmlinclude Frenet2WorldService-response.msg.html

(cl:defclass <Frenet2WorldService-response> (roslisp-msg-protocol:ros-message)
  ((world_pose
    :reader world_pose
    :initarg :world_pose
    :type global_planner-msg:WorldPose
    :initform (cl:make-instance 'global_planner-msg:WorldPose)))
)

(cl:defclass Frenet2WorldService-response (<Frenet2WorldService-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Frenet2WorldService-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Frenet2WorldService-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name global_planner-srv:<Frenet2WorldService-response> is deprecated: use global_planner-srv:Frenet2WorldService-response instead.")))

(cl:ensure-generic-function 'world_pose-val :lambda-list '(m))
(cl:defmethod world_pose-val ((m <Frenet2WorldService-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader global_planner-srv:world_pose-val is deprecated.  Use global_planner-srv:world_pose instead.")
  (world_pose m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Frenet2WorldService-response>) ostream)
  "Serializes a message object of type '<Frenet2WorldService-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'world_pose) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Frenet2WorldService-response>) istream)
  "Deserializes a message object of type '<Frenet2WorldService-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'world_pose) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Frenet2WorldService-response>)))
  "Returns string type for a service object of type '<Frenet2WorldService-response>"
  "global_planner/Frenet2WorldServiceResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Frenet2WorldService-response)))
  "Returns string type for a service object of type 'Frenet2WorldService-response"
  "global_planner/Frenet2WorldServiceResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Frenet2WorldService-response>)))
  "Returns md5sum for a message object of type '<Frenet2WorldService-response>"
  "7c3d04499a34679df3b3eaae1ccad4b8")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Frenet2WorldService-response)))
  "Returns md5sum for a message object of type 'Frenet2WorldService-response"
  "7c3d04499a34679df3b3eaae1ccad4b8")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Frenet2WorldService-response>)))
  "Returns full string definition for message of type '<Frenet2WorldService-response>"
  (cl:format cl:nil "WorldPose world_pose~%~%================================================================================~%MSG: global_planner/WorldPose~%float64 x~%float64 y~%float64 yaw~%float64 v~%float64 acc~%float64 target_v~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Frenet2WorldService-response)))
  "Returns full string definition for message of type 'Frenet2WorldService-response"
  (cl:format cl:nil "WorldPose world_pose~%~%================================================================================~%MSG: global_planner/WorldPose~%float64 x~%float64 y~%float64 yaw~%float64 v~%float64 acc~%float64 target_v~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Frenet2WorldService-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'world_pose))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Frenet2WorldService-response>))
  "Converts a ROS message object to a list"
  (cl:list 'Frenet2WorldService-response
    (cl:cons ':world_pose (world_pose msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'Frenet2WorldService)))
  'Frenet2WorldService-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'Frenet2WorldService)))
  'Frenet2WorldService-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Frenet2WorldService)))
  "Returns string type for a service object of type '<Frenet2WorldService>"
  "global_planner/Frenet2WorldService")