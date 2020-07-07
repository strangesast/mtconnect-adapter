 
FROM debian

RUN apt-get update && apt-get -y install git build-essential cmake libxml2-dev libcppunit-dev ruby curl
RUN git clone --recurse-submodules https://github.com/strangesast/mtconnect-cppagent.git /agent

RUN cd /agent && \
  mkdir build && cd build && \
  cmake --config Release .. && \
  cmake --build . --config Release --target agent && \
  make

WORKDIR /agent/build

COPY agent.cfg fanuc.xml ./

CMD ["/agent/build/agent/agent", "run"]
