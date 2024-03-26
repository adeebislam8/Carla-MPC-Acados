;; Auto-generated. Do not edit!


(when (boundp 'global_planner::Frenet2WorldService)
  (if (not (find-package "GLOBAL_PLANNER"))
    (make-package "GLOBAL_PLANNER"))
  (shadow 'Frenet2WorldService (find-package "GLOBAL_PLANNER")))
(unless (find-package "GLOBAL_PLANNER::FRENET2WORLDSERVICE")
  (make-package "GLOBAL_PLANNER::FRENET2WORLDSERVICE"))
(unless (find-package "GLOBAL_PLANNER::FRENET2WORLDSERVICEREQUEST")
  (make-package "GLOBAL_PLANNER::FRENET2WORLDSERVICEREQUEST"))
(unless (find-package "GLOBAL_PLANNER::FRENET2WORLDSERVICERESPONSE")
  (make-package "GLOBAL_PLANNER::FRENET2WORLDSERVICERESPONSE"))

(in-package "ROS")





(defclass global_planner::Frenet2WorldServiceRequest
  :super ros::object
  :slots (_frenet_pose ))

(defmethod global_planner::Frenet2WorldServiceRequest
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

(defclass global_planner::Frenet2WorldServiceResponse
  :super ros::object
  :slots (_world_pose ))

(defmethod global_planner::Frenet2WorldServiceResponse
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

(defclass global_planner::Frenet2WorldService
  :super ros::object
  :slots ())

(setf (get global_planner::Frenet2WorldService :md5sum-) "7c3d04499a34679df3b3eaae1ccad4b8")
(setf (get global_planner::Frenet2WorldService :datatype-) "global_planner/Frenet2WorldService")
(setf (get global_planner::Frenet2WorldService :request) global_planner::Frenet2WorldServiceRequest)
(setf (get global_planner::Frenet2WorldService :response) global_planner::Frenet2WorldServiceResponse)

(defmethod global_planner::Frenet2WorldServiceRequest
  (:response () (instance global_planner::Frenet2WorldServiceResponse :init)))

(setf (get global_planner::Frenet2WorldServiceRequest :md5sum-) "7c3d04499a34679df3b3eaae1ccad4b8")
(setf (get global_planner::Frenet2WorldServiceRequest :datatype-) "global_planner/Frenet2WorldServiceRequest")
(setf (get global_planner::Frenet2WorldServiceRequest :definition-)
      "FrenetPose frenet_pose

================================================================================
MSG: global_planner/FrenetPose
float64 s
float64 s_dot
float64 s_ddot
float64 d
float64 d_dot
float64 d_ddot
---
WorldPose world_pose

================================================================================
MSG: global_planner/WorldPose
float64 x
float64 y
float64 yaw
float64 v
float64 acc
")

(setf (get global_planner::Frenet2WorldServiceResponse :md5sum-) "7c3d04499a34679df3b3eaae1ccad4b8")
(setf (get global_planner::Frenet2WorldServiceResponse :datatype-) "global_planner/Frenet2WorldServiceResponse")
(setf (get global_planner::Frenet2WorldServiceResponse :definition-)
      "FrenetPose frenet_pose

================================================================================
MSG: global_planner/FrenetPose
float64 s
float64 s_dot
float64 s_ddot
float64 d
float64 d_dot
float64 d_ddot
---
WorldPose world_pose

================================================================================
MSG: global_planner/WorldPose
float64 x
float64 y
float64 yaw
float64 v
float64 acc
")



(provide :global_planner/Frenet2WorldService "7c3d04499a34679df3b3eaae1ccad4b8")


