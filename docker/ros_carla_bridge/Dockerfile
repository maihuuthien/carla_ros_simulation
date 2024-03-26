# First stage sets up the base, ie everything except the active dev repo
FROM osrf/ros:humble-desktop-jammy

ARG CARLA_VERSION=0.9.13
ARG UBUNTU_VERSION=22.04

SHELL ["/bin/bash", "-c"]

RUN apt update && apt install -y \
    ros-humble-perception-pcl \
    ros-humble-rqt-gui-py \
    ros-humble-derived-object-msgs \
    ros-humble-cv-bridge \
    wget \
    python3-pip \
    xdg-user-dirs

RUN mkdir -p /opt/carla-ros-bridge
WORKDIR /opt/carla-ros-bridge

RUN mkdir src && \
    cd src && \
    wget --no-check-certificate https://github.com/gezp/carla_ros/archive/refs/tags/carla-${CARLA_VERSION}-ubuntu-${UBUNTU_VERSION}.tar.gz && \
    tar -xzvf carla-${CARLA_VERSION}-ubuntu-${UBUNTU_VERSION}.tar.gz && \
    rm -f carla-${CARLA_VERSION}-ubuntu-${UBUNTU_VERSION}.tar.gz && \
    mv carla_ros-carla-${CARLA_VERSION}-ubuntu-${UBUNTU_VERSION} ros-bridge && \
    cd ros-bridge && \
    wget --no-check-certificate https://github.com/carla-simulator/ros-carla-msgs/archive/refs/tags/1.3.0.tar.gz && \
    tar -xzvf 1.3.0.tar.gz && \
    rm -f 1.3.0.tar.gz && \
    mv ros-carla-msgs-1.3.0 carla_msgs

COPY PclRecorderROS2.h ./src/ros-bridge/pcl_recorder/include/PclRecorderROS2.h

RUN rosdep update && rosdep install --from-paths src --ignore-src -r
RUN source /opt/ros/${ROS_DISTRO}/setup.bash && \
    colcon build --symlink-install

RUN python3 -m pip install --upgrade pip && python3 -m pip install numpy pygame
RUN wget --no-check-certificate https://github.com/gezp/carla_ros/releases/download/carla-${CARLA_VERSION}-ubuntu-${UBUNTU_VERSION}/carla-${CARLA_VERSION}-cp310-cp310-linux_x86_64.whl && \
    pip3 install carla-${CARLA_VERSION}-cp310-cp310-linux_x86_64.whl

COPY ros_entrypoint.sh /

# Ensure script is executable
RUN ["sudo", "chmod", "+x", "/ros_entrypoint.sh"]

ENTRYPOINT ["/ros_entrypoint.sh"]