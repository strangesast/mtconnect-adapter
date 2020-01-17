FROM debian
RUN apt-get update && apt-get install -y git wget build-essential
WORKDIR /tmp
RUN mkdir /tmp/fanuc
#RUN wget -O /tmp/fanuc/Fwlib32.h https://raw.githubusercontent.com/johnmichaloski/Adapter---fanuc-iSeries/master/Fwlib/0i/fwlib32.h
RUN wget -O /tmp/fanuc/Fwlib32.h https://raw.githubusercontent.com/micousuen/dcourier/master/src/fwlib32.h
RUN git clone https://github.com/mtconnect/adapter.git && \
  cd adapter && \
  cp fanuc/adapter.ini /tmp/fanuc/ && \
  cp fanuc/fanuc.xml /tmp/fanuc/ && \
  cp fanuc/*.cpp /tmp/fanuc/ && \
  cp fanuc/*.hpp /tmp/fanuc/ && \
  cp src/*.cpp /tmp/fanuc/ && \
  cp src/*.hpp /tmp/fanuc/ && \
  cp minIni_07/*.c /tmp/fanuc/ && \
  cp minIni_07/*.h /tmp/fanuc/ && \
  cd /tmp/fanuc && \
  g++ minIni.c device_datum.cpp fanuc_axis.cpp fanuc_path.cpp service.cpp condition.cpp cutting_tool.cpp string_buffer.cpp logger.cpp client.cpp server.cpp adapter.cpp fanuc_adapter.cpp FanucAdapter.cpp -lfwlib32 -lpthread -o adapter

