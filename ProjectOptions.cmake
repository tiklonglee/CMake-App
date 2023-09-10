# Generate compile_commands.json for clang-tools
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

macro(setup_options)
    option(WARNINGS_AS_ERRORS "Consider Warnings As Errors" ON)
    option(ENABLE_CLANG_TIDY "Enable clang-tidy" ON)
    option(ENABLE_CPPCHECK "Enable cpp-check" ON)
    option(ENABLE_INCLUDE_WHAT_YOU_USE "Enable include-what-you-use" ON)
    option(ENABLE_LINK_WHAT_YOU_USE "Enable link-what-you-use" ON)

    option(ENABLE_SANITIZER_ADDRESS "Enable address sanitizer" OFF)
    option(ENABLE_SANITIZER_LEAK "Enable leak sanitizer" OFF)
    option(ENABLE_SANITIZER_UNDEFINED "Enable undefined sanitizer" OFF)
    option(ENABLE_SANITIZER_THREAD "Enable thread sanitizer" OFF)
    option(ENABLE_SANITIZER_MEMORY "Enable memory sanitizer" OFF)

    option(ENABLE_IPO "Enable IPO/LTO" ON)
    option(ENABLE_PCH "Enable PCH" OFF)
    option(ENABLE_CACHE "Enable ccache" ON)
    option(ENABLE_UNITY_BUILD "Enable unity builds" OFF)
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
    if(ENABLE_INCLUDE_WHAT_YOU_USE)
        enable_include_what_you_use()
    endif()
    if(ENABLE_LINK_WHAT_YOU_USE)
        enable_link_what_you_use()
    endif()

    include(cmake/Sanitizers.cmake)
    enable_sanitizers(default_interface)

    if(ENABLE_IPO)
        include(cmake/InterproceduralOptimization.cmake)
        enable_ipo()
    endif()

    if(ENABLE_PCH)
        message(STATUS "Enabled PCH")
        target_precompile_headers(
            default_interface
            INTERFACE
        )
    endif()

    if(ENABLE_CACHE)
        include(cmake/Cache.cmake)
        enable_cache()
    endif()

    if(ENABLE_UNITY_BUILD)
        message(STATUS "Enabled UNITY_BUILD")
        set_target_properties(default_interface PROPERTIES UNITY_BUILD ${ENABLE_UNITY_BUILD})
    endif()
endmacro()
