# First stage sets up the base, ie everything except the active dev repo
FROM osrf/ros:foxy-desktop-focal AS base

ARG CARLA_VERSION=0.9.13
ARG UBUNTU_VERSION=20.04

SHELL ["/bin/bash", "-c"]

RUN apt update && apt install -y --no-install-recommends \
    wget \
    python3-pip \
    ros-foxy-derived-object-msgs \
    ros-foxy-ackermann-msgs

RUN sudo apt install python3-colcon-common-extensions

RUN mkdir -p ~/carla-ros-bridge
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

RUN rosdep update && rosdep install --from-paths src --ignore-src -r
RUN source /opt/ros/foxy/setup.bash && \
    colcon build --symlink-install

RUN python3 -m pip install --upgrade pip && python3 -m pip install numpy pygame
RUN wget --no-check-certificate https://github.com/gezp/carla_ros/releases/download/carla-${CARLA_VERSION}-ubuntu-${UBUNTU_VERSION}/carla-${CARLA_VERSION}-cp38-cp38-linux_x86_64.whl && \
    pip3 install carla-${CARLA_VERSION}-cp38-cp38-linux_x86_64.whl

COPY ros_entrypoint.sh /

# Ensure script is executable
RUN ["sudo", "chmod", "+x", "/ros_entrypoint.sh"]

ENTRYPOINT ["/ros_entrypoint.sh"]