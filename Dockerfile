from debian as base

# can't use default value with buildx
arg TARGETPLATFORM

# when using default builder:
#arg TARGETPLATFORM=linux/amd64
#env TARGETPLATFORM=$TARGETPLATFORM

run apt-get update && apt-get install -y libc6-dev gettext-base
run echo $TARGETPLATFORM
copy fanuc/fwlib32/${TARGETPLATFORM}/libfwlib32.so.1.0.5 /usr/local/lib/
run ln -s /usr/local/lib/libfwlib32.so.1.0.5 /usr/local/lib/libfwlib32.so && ldconfig

from base as builder
workdir /adapter
run apt-get install -y g++ cmake
copy . . 
run mkdir build && cd build && cmake .. && make

from base
volume /var/log/adapter
copy --from=builder /adapter/build/fanuc/adapter_fanuc /adapter_fanuc
copy fanuc/default.ini entrypoint.sh /
entrypoint /entrypoint.sh
