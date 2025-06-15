export PYTHONNOUSERSITE=1

export CUDNN_INCLUDE_DIR="${HOME}/workspace/dev/cudnn/include"
export CUDNN_LIB_DIR="${HOME}/workspace/dev/cudnn/lib"

export LD_LIBRARY_PATH="${CONDA_PREFIX}/lib:${LD_LIBRARY_PATH}"
export LD_LIBRARY_PATH="${CUDNN_LIB_DIR}:${LD_LIBRARY_PATH}"
export LD_LIBRARY_PATH="${HOME}/workspace/dev/cuda/extras/CUPTI/lib64:${LD_LIBRARY_PATH}"
export LD_LIBRARY_PATH="${HOME}/workspace/dev/cuda/targets/x86_64-linux/lib:${LD_LIBRARY_PATH}"

export CC="${CONDA_PREFIX}/bin/gcc"
export CXX="${CONDA_PREFIX}/bin/g++"

export CFLAGS="${CFLAGS} -I${CONDA_PREFIX}/include"
export CFLAGS="${CFLAGS} -I${CUDNN_INCLUDE_DIR}"

export LDFLAGS="${LDFLAGS} -L${CONDA_PREFIX}/lib"
export LDFLAGS="${LDFLAGS} -L${CUDNN_LIB_DIR}"
export LDFLAGS="${LDFLAGS} -L${HOME}/workspace/dev/cuda/extras/CUPTI/lib64"
export LDFLAGS="${LDFLAGS} -L${HOME}/workspace/dev/cuda/targets/x86_64-linux/lib"
