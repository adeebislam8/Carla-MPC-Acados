#!/usr/bin/env bash
# export CARLA_ROOT=carla
export PYTHONPATH=$PYTHONPATH:carla/CARLA_0.9.13/PythonAPI/carla/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:"src/mpc_controller/src/acados/lib"
export ACADOS_SOURCE_DIR="src/mpc_controller/src/acados/"

bash carla/CarlaUE4.sh 

sleep 4

source devel/setup.bash

roslaunch mpc_controller mpcc_all.launch