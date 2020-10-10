#!/bin/sh
deps="libc6-dev g++ cmake"
if [ "$TARGETPLATFORM" = "linux/amd64" ]
then
  deps="${deps} g++-multilib"
fi
apt-get install -y $deps
