# First stage sets up the base, ie everything except the active dev repo
FROM osrf/ros:humble-desktop-jammy

# Setup ROS 2 Workspace
SHELL ["/bin/bash", "-c"]

# RUN mkdir /ros2_ws
COPY ros2_ws ros2_ws 

RUN cd ros2_ws && \
    source /opt/ros/humble/setup.bash && \
    colcon build

COPY ./ros_entrypoint.sh /

# Ensure script is executable
RUN ["chmod", "+x", "/ros_entrypoint.sh"]

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
