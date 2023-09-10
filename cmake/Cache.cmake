# Enable cache if available
function(enable_cache)
    find_program(CCACHE_BINARY "ccache")

    if(CCACHE_BINARY)
        message(STATUS "Enabled ${CCACHE_BINARY}")
        set(CMAKE_CXX_COMPILER_LAUNCHER ${CCACHE_BINARY})
    else()
        message(WARNING "Enabled ccache but cannot found the binary. Not using it")
    endif()
endfunction()
