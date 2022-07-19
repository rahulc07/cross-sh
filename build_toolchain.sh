#!/bin/bash
set -e

error_check() {
	if [[ ! $1 == 0 ]]; then
		echo "Error check the build directory"
		exit 1
	fi
}
source toolchain.conf

echo "Starting build for $ARCH with $LIBC, the triplet is $TARGET_CROSS"

echo "Building Binutils..."
bash toolchain_binutils.sh &> /dev/null
error_check "$?"
echo "Building GCC Stage 1..."
bash toolchain_gcc_static.sh &> /dev/null
error_check "$?"
echo "Copying the Linux API Headers..."
bash toolchain_linux_headers.sh &> /dev/null
error_check "$?"
if [[ $LIBC == GLIBC ]]
then
   echo "Building GLIBC"
   bash toolchain_glibc.sh &> /dev/null
   error_check "$?"
elif [[ $LIBC == MUSL ]]
then
   echo "Building Musl"
   bash toolchain_musl.sh &> /dev/null
   error_check "$?"
elif [[ $LIBC == PICOLIBC ]]
then
   bash toolchain_picolibc &> /dev/null
   error_check "$?"
elif [[ $LIBC == NEWLIB ]]
then
    bash toolchain_newlib.sh &> /dev/null
    error_check "$?"
else 
	echo "LIBC Variable is invalid check your toolchain.conf"
fi


echo "Building the final stage of GCC..."
bash toolchain_gcc_final.sh &> /dev/null
error_check "$?"
echo "All Done, remember to add $LOCATION/usr/bin to your path"
