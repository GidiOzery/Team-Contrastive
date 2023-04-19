# Copyright 2020 Toyota Research Institute.  All rights reserved.

FROM nvidia/cuda:10.1-devel-ubuntu18.04

#ARG DEBIAN_FRONTEND=noninteractive

ENV PROJECT=permatrack
ENV PYTORCH_VERSION=1.4
ENV TORCHVISION_VERSION=0.5.0
ENV CUDNN_VERSION=7.6.2-1+cuda10.1
ENV NCCL_VERSION=2.4.8-1+cuda10.1
ENV TRT_VERSION=6.0.1.5
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

ENV OS=ubuntu1804
ARG python=3.6
ENV PYTHON_VERSION=${python}
ENV DEBIAN_FRONTEND=noninteractive
ENV CUDA_VERSION=10.1

# Set default shell to /bin/bash
SHELL ["/bin/bash", "-cu"]
#RUN apt-key adv --keyserver keyserver.ubuntu.com 871920D1991BC93C
#RUN apt-get install -y sudo && sudo apt-get install gcc && sudo apt-get install -y software-properties-common
RUN apt-get update && apt-get install -y apt-utils && apt-get install -y sudo && sudo apt-get install gcc && sudo apt-get install -y software-properties-common && sudo apt-get install -y python3-distutils

ENV TZ=Europe/Amsterdam \
    DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install tzdata

#RUN wget https://developer.download.nvidia.com/compute/cuda/repos/${OS}/x86_64/cuda-${OS}.pin 
#RUN sudo mv cuda-${OS}.pin /etc/apt/preferences.d/cuda-repository-pin-600
#RUN sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/${OS}/x86_64/3bf863cc.pub
#RUN sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/${OS}/x86_64/ /"
#RUN ls ./home
#RUN ls ./tmp
#RUN ls ./usr
COPY ./docker/nccl-repo-ubuntu1804-2.4.8-ga-cuda10.1_1-1_amd64.deb /tmp/nccl-repo-ubuntu1804-2.4.8-ga-cuda10.1_1-1_amd64.deb 
RUN ls /tmp
#RUN apt-get update --allow-unauthenticated
#RUN apt-get update --allow-insecure-repositories
RUN sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F60F4B3D7FA2AF80 
RUN sudo dpkg -i /tmp/nccl-repo-ubuntu1804-2.4.8-ga-cuda10.1_1-1_amd64.deb

RUN sudo apt-get update && sudo apt-get install -y --allow-downgrades --allow-change-held-packages --no-install-recommends \
    build-essential \
    cmake \
    g++-4.8 \
    git \
    curl \
    docker.io \
    vim \
    wget \
    ca-certificates \
#    libcudnn7=${CUDNN_VERSION} \
#    libcudnn7-dev=${CUDNN_VERSION} \
    libnccl2=${NCCL_VERSION} \
    libnccl-dev=${NCCL_VERSION} \
    libjpeg-dev \
    libpng-dev \
    python${PYTHON_VERSION} \
    python${PYTHON_VERSION}-dev \
    python3-tk \
    librdmacm1 \
    libibverbs1 \
    libgtk2.0-dev \
    unzip \
    bzip2 \
    htop \
    gnuplot \
    ffmpeg

#RUN wget https://developer.nvidia.com/compute/machine-learning/cudnn/secure/7.6.5.32/Production/10.1_20191031/cudnn-10.1-linux-x64-v7.6.5.32.tgz
#RUN file cudnn-10.1-linux-x64-v7.6.5.32.tgz
#RUN tar -xvf ~/home2/permatrack/docker/cudnn-10.1-linux-x64-v7.6.5.32.tgz
#RUN ls
#RUN ls/usr
#RUN ls/home
#RUN ls/root
#RUN ls ~/home2/permatrack/docker/
#RUN sudo cp ~/home2/permatrack/docker/cuda/include/cudnn.h /usr/local/cuda/include
#RUN sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
#RUN sudo chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*
COPY ./docker/cuda/include/cudnn.h /usr/local/cuda/include
COPY ./docker/cuda/lib64/libcudnn* /usr/local/cuda/lib64/
RUN sudo chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*

#RUN wget https://developer.nvidia.com/compute/machine-learning/cudnn/secure/7.6.5.32/Production/10.1_20191031/Ubuntu18_04-x64/libcudnn7_7.6.5.32-1+cuda10.1_amd64.deb
#RUN sudo dpkg -i libcudnn7_7.6.5.32-1+cuda10.1_amd64.deb
#RUN wget https://developer.nvidia.com/compute/machine-learning/cudnn/secure/7.6.5.32/Production/10.1_20191031/Ubuntu18_04-x64/libcudnn7-dev_7.6.5.32-1+cuda10.1_amd64.deb
#RUN sudo dpkg -i libcudnn7-dev_7.6.5.32-1+cuda10.1_amd64.deb
#RUN wget https://developer.download.nvidia.com/compute/redist/nccl/v2.4/nccl_2.4.8-1+cuda10.1_x86_64.txz



# Install OpenSSH for MPI to communicate between containers
RUN apt-get install -y --no-install-recommends openssh-client openssh-server && \
    mkdir -p /var/run/sshd

RUN ln -sf /usr/bin/python${PYTHON_VERSION} /usr/bin/python

RUN curl -O https://bootstrap.pypa.io/pip/3.6/get-pip.py && \
    python get-pip.py && \
    rm get-pip.py

RUN pip install --upgrade pip setuptools wheel

# Install Pydata and other deps
RUN pip install easydict scipy numpy pyquaternion matplotlib jupyter h5py \
    awscli nuscenes-devkit tqdm progress path.py pyyaml opencv-python \
    pycuda numba cython motmetrics scikit-learn==0.22.2 moviepy imageio yacs --verbose
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git

# Install PyTorch
RUN pip install torch==${PYTORCH_VERSION} \
    torchvision==${TORCHVISION_VERSION} && ldconfig

RUN pip install -U 'git+https://github.com/cocodataset/cocoapi.git#subdirectory=PythonAPI'

RUN pip3 install git+https://github.com/achalddave/python-script-utils.git@v0.0.2#egg=script_utils

# create project workspace dir
RUN mkdir -p /workspace/experiments
RUN mkdir -p /workspace/${PROJECT}
WORKDIR /workspace/${PROJECT}

# Copy project source last (to avoid cache busting)
WORKDIR /workspace/${PROJECT}
COPY . /workspace/${PROJECT}
ENV PYTHONPATH="/workspace/${PROJECT}:$PYTHONPATH"
