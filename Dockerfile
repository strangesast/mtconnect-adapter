from debian:buster-slim as base

# can't use default value with buildx
arg TARGETPLATFORM
arg VERSION=1.0.5
env TARGETPLATFORM=$TARGETPLATFORM
env VERSION=$VERSION

run apt-get update && apt-get -y install gettext-base && apt-get clean
copy scripts/install-fwlib32.sh fanuc/fwlib/libfwlib32* fanuc/fwlib/fwlib32.h /tmp/
run cd /tmp/ && ./install-fwlib32.sh

from base as builder

workdir /usr/src/mtconnect-adapter

copy scripts/install-deps.sh /tmp/
run /tmp/install-deps.sh

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

volume /var/log/adapter
healthcheck cmd /adapter/healthcheck.sh
entrypoint /adapter/entrypoint.sh
