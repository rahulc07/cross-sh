#!/bin/bash
set -e
# Source the configuration
source toolchain.conf

pkg=glibc
# Untar

cd $BUILD_DIR
tar -xvf $SOURCES_DIR/$pkg-$GLIBC_VER.tar.xz
cd $pkg-$GLIBC_VER

# Start the build

mkdir build
cd build

../configure --prefix=/usr --host=$TARGET_CROSS --with-headers=$LOCATION/usr/include

make -j$JOBS

make DESTDIR=$LOCATION install

# Delete the old files
cd $BUILD_DIR
rm -rf $pkg-$GLIBC_VER
