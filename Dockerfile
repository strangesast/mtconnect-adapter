from debian as base

run dpkg --add-architecture i386 && apt-get update && apt-get install -y gcc-multilib g++-multilib libc6-dev libc6-dev:i386 gettext-base netcat
copy fanuc/libfwlib32.so.1.0.0 /usr/local/lib/
run ln -s /usr/local/lib/libfwlib32.so.1.0.0 /usr/local/lib/libfwlib32.so && ldconfig

from base as builder
workdir /adapter
run apt-get install -y g++ cmake
copy . . 
run mkdir build && cd build && cmake .. && make

from base
volume /var/log/adapter
copy --from=builder /adapter/build/fanuc/adapter_fanuc /adapter_fanuc
copy fanuc/default.ini healthcheck.sh entrypoint.sh /
healthcheck cmd /healthcheck.sh
entrypoint /entrypoint.sh
