#project name
PROJECT(tools)
cmake_minimum_required(VERSION 2.8)
set(CMAKE_VERBOSE_MAKEFILE on)
#set(CMAKE_C_FLAGS "-std=c++11 -g -Wall -Werror")
set(CMAKE_CXX_FLAGS "-std=c++11 -Wall -Werror -Wl,--as-needed")

set(psnr_files  psnr/psnr.c)
#add executable file
#ADD_EXECUTABLE(../bin/bin ${PIXEL_STRIP})
add_executable(psnr ${psnr_files})
#add link library
TARGET_LINK_LIBRARIES(psnr m)

set(pixel_convert_files  pixel_convert/pixel_convert.c)
add_executable(pixel_convert ${pixel_convert_files})

