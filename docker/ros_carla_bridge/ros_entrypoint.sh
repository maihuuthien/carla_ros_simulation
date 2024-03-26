#!/bin/bash
set -e

source /opt/ros/foxy/setup.bash
source /opt/carla-ros-bridge/install/setup.bash

exec "$@"
