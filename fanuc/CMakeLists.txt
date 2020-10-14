add_executable (adapter_fanuc fanuc_axis.cpp fanuc_path.cpp fanuc_adapter.cpp FanucAdapter.cpp)
target_include_directories (adapter_fanuc PUBLIC ../src ../minIni_07)

find_package(Threads REQUIRED)

if(CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64")
  target_compile_options(adapter_fanuc PRIVATE -m32 -lfwlib32 -pthread)
  target_link_libraries(adapter_fanuc fwlib32 adapter_generic minIni pthread -m32 -lfwlib32)
else()
  target_compile_options(adapter_fanuc PRIVATE -lfwlib32 -pthread)
  target_link_libraries(adapter_fanuc fwlib32 adapter_generic minIni pthread -lfwlib32)
endif()

install (TARGETS adapter_fanuc DESTINATION /usr/local/bin)
