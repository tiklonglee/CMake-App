# Choose the linker to be used
macro(configure_linker target)
    include(CheckCXXCompilerFlag)

    set(USER_LINKER "lld" CACHE STRING "Linker to be used")
    set(LINKER_FLAG "-fuse-ld=${USER_LINKER}")

    check_cxx_compiler_flag(${LINKER_FLAG} CXX_SUPPORTS_USER_LINKER)
    if(CXX_SUPPORTS_USER_LINKER)
        message(STATUS "Using ${USER_LINKER} linker")
        target_link_options(${target} INTERFACE ${LINKER_FLAG})
    endif()
endmacro()
