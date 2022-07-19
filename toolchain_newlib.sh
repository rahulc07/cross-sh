#!/bin/bash
set -e
# Source the configuration
source toolchain.conf

pkg=newlib
# Untar

cd $BUILD_DIR
tar -xvf $SOURCES_DIR/$pkg-$NEWLIB_VER.tar.xz
cd $pkg-$NEWLIB_VER

# Start the build

mkdir build
cd build

../configure --prefix=/usr --host=$TARGET_CROSS --with-headers=$LOCATION/include

make -j$JOBS

make DESTDIR=$LOCATION install

# Delete the old files
cd $BUILD_DIR
rm -rf $pkg-$NEWLIB_VER
