cmake_minimum_required(VERSION 3.1)
project(torch_gpu_debug)

set(Torch_DIR "/usr/local/libtorch_gpu/share/cmake/Torch/")

find_package(PythonInterp REQUIRED)
find_package(Torch REQUIRED)
include_directories(${TORCH_INCLUDE_DIRS})

message(STATUS "Find Torch VERSION: ${Torch_VERSION}")
add_definitions(-DTORCH_VERSION_MAJOR=${Torch_VERSION_MAJOR})
add_definitions(-DTORCH_VERSION_MINOR=${Torch_VERSION_MINOR})
add_definitions(-DTORCH_VERSION_PATCH=${Torch_VERSION_PATCH})

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${TORCH_CXX_FLAGS} -Wno-dev")
add_executable(torch_gpu_debug torch_debug.cc)
target_link_libraries(torch_gpu_debug ${TORCH_LIBRARIES})
set_property(TARGET torch_gpu_debug PROPERTY CXX_STANDARD 14)