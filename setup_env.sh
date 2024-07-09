#!/usr/bin/env bash

set -e  # Exit immediately if a command exits with a non-zero status

# Set working directory
export WORKING_DIR=${PWD}
echo "Working directory: ${WORKING_DIR}"

# Install Python dependencies
pip install -r requirements.txt

# Install system dependencies
sudo apt-get update
sudo apt-get install -y libomp5

# Download and install CARLA
echo "Downloading CARLA..."
mkdir -p carla
cd carla
wget https://carla-releases.s3.us-east-005.backblazeb2.com/Linux/CARLA_0.9.13.tar.gz
# wget https://carla-releases.s3.us-east-005.backblazeb2.com/Linux/AdditionalMaps_0.9.10.1.tar.gz
tar -xf CARLA_0.9.13.tar.gz
# tar -xf AdditionalMaps_0.9.10.1.tar.gz
rm CARLA_0.9.13.tar.gz
# rm AdditionalMaps_0.9.10.1.tar.gz
cd ..

# Clone and build acados
echo "Cloning and building acados..."
cd src/mpc_controller/src
git clone https://github.com/acados/acados.git
cd acados
git submodule update --recursive --init

mkdir -p build
cd build
cmake -DACADOS_WITH_QPOASES=ON ..
make install -j4

# Install acados Python interface
cd ..
pip install -e interfaces/acados_template

# Clone the ROS bridge for CARLA
echo "Cloning ROS bridge for CARLA..."
cd ${WORKING_DIR}/src
git clone --recurse-submodules https://github.com/carla-simulator/ros-bridge.git

# Install ROS dependencies
cd ..
rosdep update
rosdep install --from-paths src --ignore-src -r -y

# Build the catkin workspace
cd ${WORKING_DIR}
catkin build

echo "Environment setup completed successfully."
