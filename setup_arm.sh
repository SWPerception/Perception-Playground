#!/bin/bash
set -e

echo "=================================="
echo " Arm Assembly ROS2/MoveIt Setup"
echo " Repo: Space-and-Satellite-Systems-UC-Davis/Controls-Playground"
echo ""
echo " This script will:"
echo "   1. Install ROS Jazzy MoveIt"
echo "   2. Detect your CPU architecture"
echo "   3. Install the correct rviz-common package"
echo "   4. Build the workspace"
echo "   5. Launch the MoveIt Setup Assistant"
echo ""
echo " Estimated time: 5-10 minutes"
echo " sudo privileges required"
echo "=================================="
echo ""

# Move into the arm_assembly directory
cd arm_assembly

#Install "install" using apt
sudo apt -f install -y

# Initial MoveIt install
sudo apt install -y ros-jazzy-moveit

# Source ROS install
source install/setup.bash

# Install wget
sudo apt install -y wget

# Detect architecture and download the appropriate rviz-common package
ARCH=$(uname -m)

if [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
    echo "Detected ARM architecture"
    wget http://snapshots.ros.org/jazzy/2025-05-23/ubuntu/pool/main/r/ros-jazzy-rviz-common/ros-jazzy-rviz-common_14.1.11-1noble.20250521.124129_arm64.deb
    sudo dpkg -i ros-jazzy-rviz-common_14.1.11-1noble.20250521.124129_arm64.deb
elif [ "$ARCH" = "x86_64" ]; then
    echo "Detected AMD/x86_64 architecture"
    wget http://snapshots.ros.org/jazzy/2025-05-23/ubuntu/pool/main/r/ros-jazzy-rviz-common/ros-jazzy-rviz-common_14.1.11-1noble.20250520.201719_amd64.deb
    sudo dpkg -i ros-jazzy-rviz-common_14.1.11-1noble.20250520.201719_amd64.deb
else
    echo "Unknown architecture: $ARCH. Please install rviz-common manually."
    exit 1
fi

# Post-install steps
source install/setup.bash

sudo apt-get update
sudo apt install -y ros-jazzy-moveit

colcon build

ros2 launch simple_arm_moveit_config demo.launch.py
