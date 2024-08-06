#!/usr/bin/env bash
# echo ${PWD}
export PYTHONPATH=$PYTHONPATH:${PWD}/carla/PythonAPI/carla/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:"${PWD}/src/mpc_controller/src/acados/lib"
export ACADOS_SOURCE_DIR="${PWD}/src/mpc_controller/src/acados/"


source devel/setup.bash

roslaunch mpc_controller mpcc_all.launch &
sleep 2

python ${PWD}/carla/PythonAPI/examples/generate_traffic.py --asynch --filterv vehicle.toyota* -s 1 -w 0 -n 40 &

sleep 2

python ${PWD}/src/mpc_controller/envs/mpc_ros_env.py


