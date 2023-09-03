# Set up static analysis with clang-tidy
macro(enable_clang_tidy)
    find_program(CLANG_TIDY clang-tidy)

    if(CLANG_TIDY AND CMAKE_CXX_COMPILER_ID MATCHES ".*Clang")
        message(STATUS "Enabled ${CLANG_TIDY}")
        set(CMAKE_CXX_CLANG_TIDY
            ${CLANG_TIDY}
            -extra-arg=-Wno-unknown-warning-option  # unknown warnings generate from another compiler
        )

        if(WARNINGS_AS_ERRORS)
            list(APPEND CMAKE_CXX_CLANG_TIDY -warnings-as-errors=*)
        endif()

        if(CMAKE_CXX_STANDARD)
            list(APPEND CMAKE_CXX_CLANG_TIDY -extra-arg=-std=c++${CMAKE_CXX_STANDARD})
        endif()
    else()
        message(WARNING "Cannot found clang-tidy executable or using non-clang compiler")
    endif()
endmacro()
