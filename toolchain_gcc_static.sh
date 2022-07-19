#!/bin/bash
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

../configure --prefix=$LOCATION/usr --disable-threads --disable-shared --with-newlib --without-headers --enable-languages=c,c++ --disable-multilib --target=$TARGET_CROSS

make all-gcc all-target-libgcc -j$JOBS

sudo make PATH=$LOCATION/bin:$PATH install-gcc install-target-libgcc

# Delete the old files
cd $BUILD_DIR
rm -rf $pkg-$CC_VER
