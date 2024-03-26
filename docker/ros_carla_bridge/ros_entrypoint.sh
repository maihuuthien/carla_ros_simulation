#!/bin/bash
set -e

source /opt/ros/humble/setup.bash
source /opt/carla-ros-bridge/install/setup.bash

XDG_RUNTIME_DIR="/tmp/xdg_runtime_dir"
mkdir -p ${XDG_RUNTIME_DIR} && chmod 777 ${XDG_RUNTIME_DIR}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR}

exec "$@"
