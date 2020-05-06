FROM debian

RUN apt-get update && apt-get install -y git \
  wget \
  gcc-multilib \
  g++-multilib \
  build-essential \
  gettext-base \
  && dpkg --add-architecture i386

WORKDIR /fanuc

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

COPY entrypoint.sh fanuc/adapter.ini.template ./

ENTRYPOINT ["/fanuc/entrypoint.sh"]
