#!/bin/bash

export FF_PATH=`pwd`

# openssl installed 
export OPENSSL_PATH=/usr/local/openssl-1.1.1j-amd64

# fstack to install
export FSTACK_PATH=/usr/local/fstack-amd64

# fstack dpdk to install
export DPDK_PATH=/usr/local/dpdk-amd64

export PKG_CONFIG_PATH=$OPENSSL_PATH/lib/pkgconfig:$DPDK_PATH/lib/x86_64-linux-gnu/pkgconfig

# build openssl
# openssl/
# chmod +x config
# ./config --prefix=$OPENSSL_PATH
# make -j 4
# make install_sw

# build dpdk
cd dpdk/
meson --prefix=$DPDK_PATH -Denable_kmods=true build
ninja -C build
ninja -C build install
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
