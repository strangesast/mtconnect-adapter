# Introduction  
These instructions are specific to the fanuc adapter on linux. It should be 
possible to adapt `CMakeLists.txt` for windows support. 

The adapter has been tested on x86\_64, armhf, and aarch64 .  The x86\_64 shared 
library from Fanuc (fwlib32-linux-x64.so.1.0.5) is broken\* so it is recommended 
to use 32bit on 64bit systems. 

# Quick Start  
```
docker run --rm \
  --network=host \
  -e FOCAS_SERVICE_NAME=<device_name> \
  -e FOCAS_HOST=<device_ip> \
  strangesast/mtconnect-adapter

# include "-v custom-adapter.ini:/adapter/$FOCAS_SERVICE_NAME.ini" to use a custom adapter config
```

# Build instructions (debian based systems)
```bash
# Get fwlib submodule
git submodule update --init --recursive
# Build dependencies
apt-get install -y cmake gcc libc6-dev
# (recommended for x64) cross compilation
dpkg --add-architecture i386
apt-get install g++-multilib libc6-dev:i386

mkdir build
cd build
cmake ..
make
make install               # optional. adds binary to path
cp ../fanuc/adapter.ini .  # edit adapter.ini to your requirements

# finally
fanuc_adapter adapter.ini
```

# Docker instructions
0. Install docker  
1. Build `docker build --build-arg TARGETPLATFORM=linux/amd64 -t mtconnect-adapter .`  
2. Run `docker run --rm -p 7878:7878 -e FOCAS_HOST=<machine_ip> mtconnect-adapter`  

Alternatively, use `docker-compose`  

# Notes
The adapter listens on port 7878 for an agent to make a request. It doesn't 
contact an actual Fanuc controller until an agent makes a request.  

To test a running adapter use netcat: `nc localhost 7878`  

Docker buildx can be used to build for multiple architectures simultaneously. For example:  
`docker buildx build --platform=linux/amd64,linux/386,linux/arm/v7 -f Dockerfile -t strangesast/mtconnect-adapter --push .`

\* About the x64 shared object library: although it will compile and run some 
fanuc api functions, it uses 32bit pointers and longs.  See [this example](https://github.com/strangesast/fwlib/blob/e82cf62be782f9300e63452a67a4865172088dc8/example/src/main.c#L39-L47) 
for a workaround for one function. The Fanuc documentation for Linux says _"In 
32bit Linux OS, type of long have 32bit length. But in 64bit Linux OS, type of 
long have 64bit length.  To absorb this difference, we define type of LONG and 
ULONG.  LONG and ULONG defined to type of 32bit length.  If you use focas2 on 
Linux, please replace long and unsigned long to LONG and ULONG on Function 
Reference.  64bit Linux is LP64(long and pointer is 64bit)."_ I have no idea 
what this means.
