# First stage sets up the base, ie everything except the active dev repo
FROM osrf/ros:foxy-desktop-focal AS base

ARG CARLA_VERSION=0.9.11
ARG ROS_BRIDGE_VERSION=${CARLA_VERSION}

SHELL ["/bin/bash", "-c"]

RUN apt update && apt install -y \
	wget \
	python3-pip

RUN sudo apt install python3-colcon-common-extensions

RUN mkdir -p ~/carla-ros-bridge
WORKDIR /root/carla-ros-bridge

# TODO: Check versions, should support up to CARLA 0.9.13
# RUN git clone --recurse-submodules https://github.com/carla-simulator/ros-bridge.git src/ros-bridge
RUN mkdir src && \
	cd src && \
	wget --no-check-certificate https://github.com/carla-simulator/ros-bridge/archive/refs/tags/${ROS_BRIDGE_VERSION}.tar.gz && \
	tar -xzvf ${ROS_BRIDGE_VERSION}.tar.gz && \
	rm -f ${ROS_BRIDGE_VERSION}.tar.gz && \
	mv ros-bridge-${ROS_BRIDGE_VERSION} ros-bridge && \
	cd ros-bridge && \
	wget --no-check-certificate https://github.com/carla-simulator/ros-carla-msgs/archive/refs/tags/1.3.0.tar.gz && \
	tar -xzvf 1.3.0.tar.gz && \
	rm -f 1.3.0.tar.gz && \
	mv ros-carla-msgs-1.3.0 carla_msgs

RUN rosdep update && rosdep install --from-paths src --ignore-src -r

RUN source /opt/ros/foxy/setup.bash && \
    colcon build

COPY ./ros_carla_bridge/ros_entrypoint.sh /

# Ensure script is executable
RUN ["sudo", "chmod", "+x", "/ros_entrypoint.sh"]

ENTRYPOINT ["/ros_entrypoint.sh"]

RUN python3 -m pip install --upgrade pip && python3 -m pip install numpy pygame

# RUN python3 -m pip install 'carla==${CARLA_VERSION}'
RUN mkdir -p /opt/carla-simulator/PythonAPI/carla/dist
COPY ./carla-${CARLA_VERSION}-py3.7-linux-x86_64.egg /opt/carla-simulator/PythonAPI/carla/dist/
ENV PYTHONPATH ${PYTHONPATH}:"/opt/carla-simulator/PythonAPI/carla/dist/carla-${CARLA_VERSION}-py3.7-linux-x86_64.egg"

