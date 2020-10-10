#!/bin/sh
version=1.0.5
platform=linux
libdir=/usr/local/lib
if [ "$TARGETPLATFORM" = "linux/amd64" ]; then
  dpkg --add-architecture i386 && apt-get update && apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386
fi
if [ "$TARGETPLATFORM" = "linux/arm/v7" ]; then
  arch=armv7
else
  arch=x86
fi
cp "libfwlib32-$platform-$arch.so.$version" "$libdir/libfwlib32.so.$version"
ln -sf "$libdir/libfwlib32.so.$version" "$libdir/libfwlib32.so"
cp fwlib32.h /usr/include/
ldconfig
