#!/bin/bash
set -e

ln -s /usr/include/lapacke.h /usr/include/$(uname -m)-linux-gnu

cd /app
rm -rf opencv opencv_contrib

git clone -b 4.11.0 --depth=1 https://github.com/KMU-FMCL/opencv.git > /dev/null 2>&1
git clone -b 4.11.0 --depth=1 https://github.com/KMU-FMCL/opencv_contrib.git > /dev/null 2>&1

cd opencv
mkdir build && cd build

cmake -G Ninja \
  -D CMAKE_BUILD_TYPE=RELEASE \
  -D CMAKE_INSTALL_PREFIX=/usr/local \
  -D CMAKE_C_STANDARD=17 \
  -D CMAKE_CXX_STANDARD=17 \
  -D OPENCV_EXTRA_MODULES_PATH=/app/opencv_contrib/modules \
  -D EIGEN_INCLUDE_PATH=/usr/include/eigen3 \
  -D WITH_OPENCL=OFF \
  -D CUDA_ARCH_BIN=${ARCH} \
  -D CUDA_ARCH_PTX=${PTX} \
  -D WITH_CUDA=ON \
  -D WITH_CUDNN=ON \
  -D WITH_CUBLAS=ON \
  -D ENABLE_FAST_MATH=ON \
  -D CUDA_FAST_MATH=ON \
  -D OPENCV_DNN_CUDA=ON \
  -D CUDA_NVCC_FLAGS="--std=c++17" \
  -D WITH_QT=OFF \
  -D WITH_OPENMP=ON \
  -D BUILD_TIFF=ON \
  -D WITH_FFMPEG=ON \
  -D WITH_GSTREAMER=ON \
  -D WITH_TBB=ON \
  -D BUILD_TBB=ON \
  -D BUILD_TESTS=OFF \
  -D WITH_EIGEN=ON \
  -D WITH_V4L=ON \
  -D WITH_LIBV4L=ON \
  -D WITH_PROTOBUF=ON \
  -D OPENCV_ENABLE_NONFREE=ON \
  -D INSTALL_C_EXAMPLES=OFF \
  -D INSTALL_PYTHON_EXAMPLES=OFF \
  -D PYTHON3_PACKAGES_PATH=/usr/lib/python3/dist-packages \
  -D OPENCV_GENERATE_PKGCONFIG=ON \
  -D BUILD_EXAMPLES=OFF ..

ninja

ninja install

ldconfig

ninja clean

rm -rf /app/opencv /app/opencv_contrib
