from debian as base

# can't use default value with buildx
arg TARGETPLATFORM
arg VERSION
env TARGETPLATFORM=$TARGETPLATFORM
env VERSION=$VERSION

run apt-get update && apt-get install -y libc6-dev gettext-base netcat
copy fanuc/fwlib32/${TARGETPLATFORM}/libfwlib32.so.${VERSION} /usr/local/lib/
run ln -s /usr/local/lib/libfwlib32.so.${VERSION} /usr/local/lib/libfwlib32.so && ldconfig

from base as builder
workdir /adapter
run apt-get install -y g++ cmake
copy . . 
arg CONTROLLER
env CONTROLLER=$CONTROLLER
#copy fanuc/fwlib32/${CONTROLLER}/Fwlib32.h fanuc/fwlib32.h
copy fanuc/fwlib32/linux/fwlib32.h fanuc/fwlib32.h
run mkdir build && cd build && cmake .. && make

from base
volume /var/log/adapter
copy --from=builder /adapter/build/fanuc/adapter_fanuc /adapter_fanuc
copy fanuc/default.ini healthcheck.sh entrypoint.sh /
healthcheck cmd /healthcheck.sh
entrypoint /entrypoint.sh
