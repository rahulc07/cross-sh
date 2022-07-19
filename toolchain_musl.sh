#!/bin/bash
set -e
# Source the configuration
source toolchain.conf

pkg=musl
# Untar

cd $BUILD_DIR
tar -xvf $SOURCES_DIR/$pkg-$MUSL_VER.tar.gz
cd $pkg-$MUSL_VER

# Start the build

mkdir build
cd build

../configure --prefix=/usr --host=$TARGET_CROSS 

make -j$JOBS

make DESTDIR=$LOCATION install

# Delete the old files
cd $BUILD_DIR
rm -rf $pkg-$MUSL_VER
