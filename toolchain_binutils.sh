#!/bin/bash
set -e
# Source the configuration
source toolchain.conf

pkg=binutils
# Untar

cd $BUILD_DIR
tar -xvf $SOURCES_DIR/$pkg-$LD_VER.tar.xz
cd $pkg-$LD_VER

# Start the build

mkdir build
cd build

../configure --prefix=$LOCATION/usr --with-sysroot=$LOCATION --disable-nls --disable-werror --target=$TARGET_CROSS

make -j$JOBS

make install

# Delete the old files
cd $BUILD_DIR
rm -rf $pkg-$LD_VER
