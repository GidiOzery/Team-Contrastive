# Setting up docker

Hi guys, here is a small explanation on how you can reproduce my docker image.

To run the file that builds the docker image, use ```make docker-build``` in the root directory of the project, **but before you do**:
- Run ```./docker/download_libs.sh``` to download the CUDNN and NCCL libraries locally. Because it is an old version you cannot download it directly from NVIDIA. These libraries are based on CUDA 10.1, so you might need to pay attention to which CUDA module you load into your account otherwise inconsistencies might occur.
- Make sure to untar the ```cudnn-10.1-linux-x64-v7.6.5.32.tgz``` file with the command ```tar -xvf cudnn-10.1-linux-x64-v7.6.5.32.tgz``` while in the ```docker``` directory. This will make a new directory called ```cuda``` with the required CUDA libraries.

FYI, the ```Makefile``` takes care of the ```make docker-build``` command. This file is pretty close to the original, other than that I've changed it to do a clean build every time your un the command. This command takes the ```Dockerfile``` in ```./docker``` to build the docker image. Note it takes a while to build everything, especially the opencv package.
