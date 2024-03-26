
(cl:in-package :asdf)

(defsystem "global_planner-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :global_planner-msg
)
  :components ((:file "_package")
    (:file "Frenet2WorldService" :depends-on ("_package_Frenet2WorldService"))
    (:file "_package_Frenet2WorldService" :depends-on ("_package"))
    (:file "World2FrenetService" :depends-on ("_package_World2FrenetService"))
    (:file "_package_World2FrenetService" :depends-on ("_package"))
  ))