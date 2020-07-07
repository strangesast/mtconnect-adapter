from debian as base

arg TARGETPLATFORM
run apt-get update && apt-get install -y libc6-dev
copy fanuc/fwlib32/${TARGETPLATFORM}/libfwlib32.so.1.0.5 /usr/local/lib/
run ln -s /usr/local/lib/libfwlib32.so.1.0.5 /usr/local/lib/libfwlib32.so && ldconfig

from base as builder
workdir /adapter
run apt-get install -y g++ cmake
copy . . 
run mkdir build && cd build && cmake .. && make

from base
run mkdir -p /var/log/adapter
copy --from=builder /adapter/build/fanuc/adapter_fanuc /adapter_fanuc
cmd ["/adapter_fanuc", "--help"]
