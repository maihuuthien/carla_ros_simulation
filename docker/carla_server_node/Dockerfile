ARG CARLA_VERSION=0.9.11

FROM carlasim/carla:${CARLA_VERSION}

USER root

COPY gpg/3bf863cc.pub .
RUN apt-key add 3bf863cc.pub

# install package
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y xdg-user-dirs

USER carla

ARG XDG_RUNTIME_DIR="/tmp/xdg_runtime_dir"
RUN mkdir -p ${XDG_RUNTIME_DIR} && chmod 777 ${XDG_RUNTIME_DIR}

RUN echo "export VK_ICD_FILENAMES=/etc/vulkan/icd.d/nvidia_icd.json" >> ~/.bashrc
RUN echo "export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR}" >> ~/.bashrc