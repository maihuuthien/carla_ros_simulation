#!/bin/sh

HOST_IP=$1
SDL_VIDEO_X11_VISUALID=$2

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

docker run -p 2000-2002:2000-2002 \
           --cpuset-cpus="0-5" \
           --runtime=nvidia \
           --gpus='all,"capabilities=graphics,utility,display,video,compute"' \
           --privileged --rm -it \
           --volume=$XSOCK:$XSOCK:rw \
           --volume=$XAUTH:$XAUTH:rw \
           --volume=$HOME:$HOME \
           --shm-size=1gb \
           --env="XAUTHORITY=${XAUTH}" \
           --env="DISPLAY=${HOST_IP}:0.0" \
           --env="SDL_VIDEO_X11_VISUALID=${SDL_VIDEO_X11_VISUALID}" \
           --env=TERM=xterm-256color \
           --env=QT_X11_NO_MITSHM=1 \
           carla_ros_simulation-carla_server:latest \
           bash