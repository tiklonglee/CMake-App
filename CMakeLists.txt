cmake_minimum_required(VERSION 3.25)
project(CMakeApp VERSION 0.0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

include(ProjectOptions.cmake)
setup_options()
local_options()

add_subdirectory(apps)
add_subdirectory(libraries)
