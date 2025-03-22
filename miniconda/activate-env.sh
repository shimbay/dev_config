#! /bin/bash

export PYTHONNOUSERSITE=1
export LD_LIBRARY_PATH=${HOME}/workspace/dev/cuda/extras/CUPTI/lib64:${LD_LIBRARY_PATH}
export LIBRARY_PATH=${HOME}/workspace/dev/cuda/extras/CUPTI/lib64:${LIBRARY_PATH}
export CUDNN_LIB_DIR=${HOME}/workspace/dev/cudnn/lib
export CUDNN_INCLUDE_DIR=${HOME}/workspace/dev/cudnn/include
export CC=${CONDA_PREFIX}/bin/gcc
export CXX=${CONDA_PREFIX}/bin/g++
