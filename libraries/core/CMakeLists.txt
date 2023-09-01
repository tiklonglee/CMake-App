add_library(core)
add_library(${PROJECT_NAME}::core ALIAS core)

target_sources(
    core
    PUBLIC
        FILE_SET HEADERS
        BASE_DIRS include
        FILES
            include/core/core.hpp
    PRIVATE
        src/core.cpp
        src/core_local.hpp
        src/core_local.cpp
)

target_include_directories(
    core
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/include
)
