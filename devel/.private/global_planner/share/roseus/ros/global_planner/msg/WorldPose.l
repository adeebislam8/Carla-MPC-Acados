;; Auto-generated. Do not edit!


(when (boundp 'global_planner::WorldPose)
  (if (not (find-package "GLOBAL_PLANNER"))
    (make-package "GLOBAL_PLANNER"))
  (shadow 'WorldPose (find-package "GLOBAL_PLANNER")))
(unless (find-package "GLOBAL_PLANNER::WORLDPOSE")
  (make-package "GLOBAL_PLANNER::WORLDPOSE"))

(in-package "ROS")
;;//! \htmlinclude WorldPose.msg.html


(defclass global_planner::WorldPose
  :super ros::object
  :slots (_x _y _yaw _v _acc _target_v ))

(defmethod global_planner::WorldPose
  (:init
   (&key
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:yaw __yaw) 0.0)
    ((:v __v) 0.0)
    ((:acc __acc) 0.0)
    ((:target_v __target_v) 0.0)
    )
   (send-super :init)
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _yaw (float __yaw))
   (setq _v (float __v))
   (setq _acc (float __acc))
   (setq _target_v (float __target_v))
   self)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:yaw
   (&optional __yaw)
   (if __yaw (setq _yaw __yaw)) _yaw)
  (:v
   (&optional __v)
   (if __v (setq _v __v)) _v)
  (:acc
   (&optional __acc)
   (if __acc (setq _acc __acc)) _acc)
  (:target_v
   (&optional __target_v)
   (if __target_v (setq _target_v __target_v)) _target_v)
  (:serialization-length
   ()
   (+
    ;; float64 _x
    8
    ;; float64 _y
    8
    ;; float64 _yaw
    8
    ;; float64 _v
    8
    ;; float64 _acc
    8
    ;; float64 _target_v
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _x
       (sys::poke _x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _y
       (sys::poke _y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _yaw
       (sys::poke _yaw (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _v
       (sys::poke _v (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _acc
       (sys::poke _acc (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _target_v
       (sys::poke _target_v (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _x
     (setq _x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _y
     (setq _y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _yaw
     (setq _yaw (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _v
     (setq _v (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _acc
     (setq _acc (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _target_v
     (setq _target_v (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get global_planner::WorldPose :md5sum-) "c9f1d062a373ad7af4375be49c38f4d5")
(setf (get global_planner::WorldPose :datatype-) "global_planner/WorldPose")
(setf (get global_planner::WorldPose :definition-)
      "float64 x
float64 y
float64 yaw
float64 v
float64 acc
float64 target_v
")



(provide :global_planner/WorldPose "c9f1d062a373ad7af4375be49c38f4d5")


