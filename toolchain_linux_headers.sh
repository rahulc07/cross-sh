#!/bin/bash

# These are usually called linux-api-headers on different distros, just in case you have some trouble with these

# Exit on error (not really needed for this package)
set -e
# Source the configuration
source toolchain.conf

# This is what the tar is called
pkg=linux
# Untar

cd $BUILD_DIR
tar -xvf $SOURCES_DIR/$pkg-$KERNEL_VER.tar.xz
cd $pkg-$KERNEL_VER

# Start the build

make ARCH=$ARCH headers
cp -rpv usr/include/* $LOCATION/usr/include

# Delete the old files
cd $BUILD_DIR
rm -rf $pkg-$KERNEL_VER
