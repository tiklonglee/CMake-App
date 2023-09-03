# Generate compile_commands.json for clang-tools
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

macro(setup_options)
    option(WARNINGS_AS_ERRORS "Consider Warnings As Errors" ON)
    option(ENABLE_CLANG_TIDY "Enable clang-tidy" ON)
    option(ENABLE_CPPCHECK "Enable cpp-check" ON)
endmacro()

macro(local_options)
    message(STATUS "Configuring local options start")
    add_library(default_interface INTERFACE)
    add_library(${PROJECT_NAME}::default_interface ALIAS default_interface)
    target_compile_features(default_interface INTERFACE cxx_std_${CMAKE_CXX_STANDARD})

    include(cmake/CompilerWarnings.cmake)
    set_target_warnings(default_interface)

    include(cmake/StaticAnalyzers.cmake)
    if(ENABLE_CLANG_TIDY)
        enable_clang_tidy()
    endif()
    if(ENABLE_CPPCHECK)
        enable_cppcheck()
    endif()
endmacro()
