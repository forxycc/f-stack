#!/bin/bash

FF_PATH=`pwd`

# arm64 tool chain
export ARM_TOOLCHAN=/opt/aarch64-gcc
export PATH=$PATH:$ARM_TOOLCHAN/bin
export CROSS_COMPILE=aarch64-linux-gnu-

# openssl installed
export OPENSSL_PATH=/usr/local/openssl-1.1.1j-aarch64

# f-stack to install
export FSTACK_PATH=/usr/local/fstack-aarch64

# f-stack dpdk to install
export DPDK_PATH=/usr/local/dpdk-aarch64

export PKG_CONFIG_PATH=$OPENSSL_PATH/lib/pkgconfig:$DPDK_PATH/lib/pkgconfig

# build openssl
#cd openssl
#./Configure linux-aarch64 --prefix=$OPENSSL_PATH no-asm
#make -j 4
#make install_sw

# build dpdk
cd dpdk/
meson cross-build --prefix=$DPDK_PATH --cross-file config/arm/arm64_dpaa_linux_gcc 
ninja -C cross-build
ninja -C cross-build install
cd ..

# build lib
cd lib/
make
make install
cd ..

# build tools
cd tools/
make
make install
cd ..

# build example
cd example/
make
cd ..
