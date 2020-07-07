add_library (minIni minIni.c)
find_package(Threads REQUIRED)
  target_compile_options( minIni PUBLIC "-pthread")

if( "$ENV{TARGETPLATFORM}" STREQUAL "linux/amd64" )
elseif( "$ENV{TARGETPLATFORM}" STREQUAL "linux/arm/v7" )
else()
  set_target_properties(minIni PROPERTIES COMPILE_FLAGS "-m32" LINK_FLAGS "-m32")
endif()
