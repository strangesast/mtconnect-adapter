FROM debian

WORKDIR /adapter

RUN apt-get update && apt-get install -y git \
  libc6-dev-i386 \
  gcc-multilib \
  g++-multilib \
  build-essential

RUN git clone https://github.com/mmxe/adapter.git && \
  cd adapter && \
  git checkout linux-compat && \
  cmake . && \
  make install

CMD ["/adapter/adapter_fanuc", "/adapter/fanuc/adapter.ini"]
