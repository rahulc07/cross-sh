#!/bin/bash

# Exit on error
set -e 

# Source the configuration
source toolchain.conf

pkg=gcc
# Untar

cd $BUILD_DIR
tar -xvf $SOURCES_DIR/$pkg-$CC_VER.tar.xz
cd $pkg-$CC_VER

# Start the build

tar -xf $SOURCES_DIR/mpfr-4.1.0.tar.xz
mv -v mpfr-4.1.0 mpfr
tar -xf $SOURCES_DIR/gmp-6.2.1.tar.xz
mv -v gmp-6.2.1 gmp
tar -xf $SOURCES_DIR/mpc-1.2.1.tar.gz
mv -v mpc-1.2.1 mpc

mkdir build
cd build

../configure --prefix=/usr --enable-languages=c,c++ --disable-multilib --target=$TARGET_CROSS --with-sysroot=$LOCATION --disable-werror 

make -j$JOBS

sudo make PATH=$LOCATION/usr/bin:$PATH DESTDIR=$LOCATION install

# Delete the old files
cd $BUILD_DIR
rm -rf $pkg-$CC_VER
