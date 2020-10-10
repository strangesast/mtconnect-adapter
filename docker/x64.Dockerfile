from debian:buster-slim as base

run apt-get update && apt-get -y install gettext-base && apt-get clean
copy fanuc/fwlib/libfwlib32-linux-x64.so.1.0.5 /usr/local/lib/libfwlib32.so.1.0.5
copy fanuc/fwlib/fwlib32.h /usr/include/
run ln -s /usr/local/lib/libfwlib32.so.1.0.5 /usr/local/lib/libfwlib32.so && ldconfig

from base as builder

workdir /usr/src/mtconnect-adapter

run apt-get update && apt-get install -y libc6-dev g++ cmake
copy . . 
run mkdir build && \
  cd build && \
  cmake .. && \
  make

from base

workdir /adapter
volume /var/log/adapter
copy --from=builder /usr/src/mtconnect-adapter/build/fanuc/adapter_fanuc /usr/local/bin/adapter_fanuc
copy ./fanuc/default.ini ./scripts/healthcheck.sh ./scripts/entrypoint.sh ./
healthcheck cmd /adapter/healthcheck.sh
entrypoint /adapter/entrypoint.sh
