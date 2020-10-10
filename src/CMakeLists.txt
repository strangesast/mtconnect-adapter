add_library (adapter_generic service.cpp adapter.cpp client.cpp condition.cpp cutting_tool.cpp device_datum.cpp logger.cpp server.cpp string_buffer.cpp)

if( "$ENV{TARGETPLATFORM}" STREQUAL "linux/amd64" )
  set_target_properties(adapter_generic PROPERTIES COMPILE_FLAGS "-m32 -pthread" LINK_FLAGS "-m32")
else()
  set_target_properties(adapter_generic PROPERTIES COMPILE_FLAGS "-pthread")
endif()

