FROM  osrf/ros:humble-desktop-full AS base

RUN apt update && apt install -y \
    ros-humble-foxglove-bridge \
    ros-humble-derived-object-msgs \
    ros-humble-ackermann-msgs \
    && \
    rm -rf /var/lib/apt/lists/*