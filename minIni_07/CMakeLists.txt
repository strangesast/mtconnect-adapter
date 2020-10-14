add_library (minIni minIni.c)
find_package(Threads REQUIRED)
target_compile_options( minIni PUBLIC "-pthread")

if(CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64")
  set_target_properties(minIni PROPERTIES COMPILE_FLAGS "-m32" LINK_FLAGS "-m32")
endif()
