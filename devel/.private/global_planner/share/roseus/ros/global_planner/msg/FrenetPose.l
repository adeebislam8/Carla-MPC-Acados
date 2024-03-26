;; Auto-generated. Do not edit!


(when (boundp 'global_planner::FrenetPose)
  (if (not (find-package "GLOBAL_PLANNER"))
    (make-package "GLOBAL_PLANNER"))
  (shadow 'FrenetPose (find-package "GLOBAL_PLANNER")))
(unless (find-package "GLOBAL_PLANNER::FRENETPOSE")
  (make-package "GLOBAL_PLANNER::FRENETPOSE"))

(in-package "ROS")
;;//! \htmlinclude FrenetPose.msg.html


(defclass global_planner::FrenetPose
  :super ros::object
  :slots (_s _s_dot _s_ddot _d _d_dot _d_ddot _yaw_s ))

(defmethod global_planner::FrenetPose
  (:init
   (&key
    ((:s __s) 0.0)
    ((:s_dot __s_dot) 0.0)
    ((:s_ddot __s_ddot) 0.0)
    ((:d __d) 0.0)
    ((:d_dot __d_dot) 0.0)
    ((:d_ddot __d_ddot) 0.0)
    ((:yaw_s __yaw_s) 0.0)
    )
   (send-super :init)
   (setq _s (float __s))
   (setq _s_dot (float __s_dot))
   (setq _s_ddot (float __s_ddot))
   (setq _d (float __d))
   (setq _d_dot (float __d_dot))
   (setq _d_ddot (float __d_ddot))
   (setq _yaw_s (float __yaw_s))
   self)
  (:s
   (&optional __s)
   (if __s (setq _s __s)) _s)
  (:s_dot
   (&optional __s_dot)
   (if __s_dot (setq _s_dot __s_dot)) _s_dot)
  (:s_ddot
   (&optional __s_ddot)
   (if __s_ddot (setq _s_ddot __s_ddot)) _s_ddot)
  (:d
   (&optional __d)
   (if __d (setq _d __d)) _d)
  (:d_dot
   (&optional __d_dot)
   (if __d_dot (setq _d_dot __d_dot)) _d_dot)
  (:d_ddot
   (&optional __d_ddot)
   (if __d_ddot (setq _d_ddot __d_ddot)) _d_ddot)
  (:yaw_s
   (&optional __yaw_s)
   (if __yaw_s (setq _yaw_s __yaw_s)) _yaw_s)
  (:serialization-length
   ()
   (+
    ;; float64 _s
    8
    ;; float64 _s_dot
    8
    ;; float64 _s_ddot
    8
    ;; float64 _d
    8
    ;; float64 _d_dot
    8
    ;; float64 _d_ddot
    8
    ;; float64 _yaw_s
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _s
       (sys::poke _s (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _s_dot
       (sys::poke _s_dot (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _s_ddot
       (sys::poke _s_ddot (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _d
       (sys::poke _d (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _d_dot
       (sys::poke _d_dot (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _d_ddot
       (sys::poke _d_ddot (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _yaw_s
       (sys::poke _yaw_s (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _s
     (setq _s (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _s_dot
     (setq _s_dot (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _s_ddot
     (setq _s_ddot (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _d
     (setq _d (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _d_dot
     (setq _d_dot (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _d_ddot
     (setq _d_ddot (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _yaw_s
     (setq _yaw_s (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get global_planner::FrenetPose :md5sum-) "57d70fe50479087b497ed2a9bcbc0f43")
(setf (get global_planner::FrenetPose :datatype-) "global_planner/FrenetPose")
(setf (get global_planner::FrenetPose :definition-)
      "float64 s
float64 s_dot
float64 s_ddot
float64 d
float64 d_dot
float64 d_ddot
float64 yaw_s
")



(provide :global_planner/FrenetPose "57d70fe50479087b497ed2a9bcbc0f43")


