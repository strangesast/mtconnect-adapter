FROM debian as build

RUN apt-get update && apt-get install -y git \
  wget \
  gcc-multilib \
  g++-multilib \
  build-essential \
  && dpkg --add-architecture i386

WORKDIR /build

COPY fanuc/libfwlib32.so.1.0.0 /usr/local/lib/libfwlib32.so
COPY fanuc/Fwlib32.h fanuc/fanuc.xml fanuc/*.cpp fanuc/*.hpp src/*.cpp src/*.hpp minIni_07/*.c minIni_07/*.h ./

RUN ldconfig && g++ \
  # -mbe32 \
  -m32 \
  minIni.c \
  device_datum.cpp \
  fanuc_axis.cpp \
  fanuc_path.cpp \
  service.cpp \
  condition.cpp \
  cutting_tool.cpp \
  string_buffer.cpp \
  logger.cpp \
  client.cpp \
  server.cpp \
  adapter.cpp \
  fanuc_adapter.cpp \
  FanucAdapter.cpp \
  -o adapter -lfwlib32 -lpthread 

RUN apt-get update && apt-get install -y gettext-base
COPY entrypoint.sh fanuc/adapter.ini.template ./

#FROM debian
#
#WORKDIR /
#
#RUN apt-get update && apt-get install -y gettext-base && dpkg --add-architecture i386
#
#COPY --from=build /build/adapter /adapter
#
#COPY entrypoint.sh fanuc/adapter.ini.template ./

#ENTRYPOINT ["entrypoint.sh"]
