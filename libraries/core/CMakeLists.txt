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
        ${CMAKE_CURRENT_BINARY_DIR}/include
)

set_target_properties(
    core
    PROPERTIES
        VERSION ${PROJECT_VERSION}
        SOVERSION ${PROJECT_VERSION_MAJOR}
        CXX_VISIBILITY_PRESET hidden
        VISIBILITY_INLINES_HIDDEN YES
)

generate_export_header(core EXPORT_FILE_NAME ${CMAKE_CURRENT_BINARY_DIR}/include/core/core_export.hpp)

if(NOT BUILD_SHARED_LIBS)
    target_compile_definitions(core PUBLIC CORE_STATIC_DEFINE)
endif()
