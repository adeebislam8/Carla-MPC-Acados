
(cl:in-package :asdf)

(defsystem "global_planner-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "FrenetPose" :depends-on ("_package_FrenetPose"))
    (:file "_package_FrenetPose" :depends-on ("_package"))
    (:file "WorldPose" :depends-on ("_package_WorldPose"))
    (:file "_package_WorldPose" :depends-on ("_package"))
  ))