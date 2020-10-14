from strangesast/fwlib as base

from base as builder

workdir /usr/src/mtconnect-adapter

copy fanuc/fwlib/build-deps.sh /tmp/
run /tmp/build-deps.sh

copy . . 
run mkdir build && \
  cd build && \
  cmake .. && \
  make

from base

# necessary for envsubst used in entrypoint
run apt-get update && apt-get -y install gettext-base && apt-get clean

workdir /adapter
volume /var/log/adapter
copy --from=builder /usr/src/mtconnect-adapter/build/fanuc/adapter_fanuc /usr/local/bin/adapter_fanuc
copy ./fanuc/default.ini ./scripts/healthcheck.sh ./scripts/entrypoint.sh ./

volume /var/log/adapter
healthcheck cmd /adapter/healthcheck.sh
entrypoint /adapter/entrypoint.sh
