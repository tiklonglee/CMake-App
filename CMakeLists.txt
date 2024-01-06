cmake_minimum_required(VERSION 3.25)
project(CMakeApp VERSION 0.0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

include(ProjectOptions.cmake)
setup_options()
local_options()

include(cmake/Package.cmake)
add_subdirectory(configure_files)
add_subdirectory(apps)
add_subdirectory(libraries)

block(SCOPE_FOR VARIABLES)
    unset(CMAKE_CXX_CLANG_TIDY)
    unset(CMAKE_CXX_CPPCHECK)
    unset(CMAKE_CXX_INCLUDE_WHAT_YOU_USE)
    unset(CMAKE_CXX_LINK_WHAT_YOU_USE)
    add_subdirectory(dependencies)
endblock()

include(CTest)
if(BUILD_TESTING)
    message(STATUS "Going to build tests")
    add_subdirectory(tests)
endif()

if(BUILD_FUZZ_TESTS)
    message(STATUS "Going to build fuzz tests")
    add_subdirectory(fuzz_tests)
endif()

configure_base_package()
include(CPack)
