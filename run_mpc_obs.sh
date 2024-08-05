#!/usr/bin/env bash
# echo ${PWD}
export PYTHONPATH=$PYTHONPATH:${PWD}/carla/PythonAPI/carla/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:"${PWD}/src/mpc_controller/src/acados/lib"
export ACADOS_SOURCE_DIR="${PWD}/src/mpc_controller/src/acados/"

python ./carla/PythonAPI/carla/examples/generate_traffic.py --asynch &
sleep 5

source devel/setup.bash

roslaunch mpc_controller mpcc_all.launch

