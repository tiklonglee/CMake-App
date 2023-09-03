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

# Set up static analysis with cppcheck
macro(enable_cppcheck)
    find_program(CPPCHECK cppcheck)

    if(CPPCHECK)
        message(STATUS "Enabled ${CPPCHECK}")
        if(CMAKE_GENERATOR MATCHES ".*Visual Studio.*")
            set(CPPCHECK_TEMPLATE "vs")
        else()
            set(CPPCHECK_TEMPLATE "gcc")
        endif()

        set(CMAKE_CXX_CPPCHECK
            ${CPPCHECK}
            --template=${CPPCHECK_TEMPLATE}
            --enable=style,performance,warning,portability
            --inline-suppr
        )

        if(WARNINGS_AS_ERRORS)
            list(APPEND CMAKE_CXX_CPPCHECK --error-exitcode=2)
        endif()

        if(CMAKE_CXX_STANDARD)
            list(APPEND CMAKE_CXX_CPPCHECK --std=c++${CMAKE_CXX_STANDARD})
        endif()
    else()
        message(WARNING "Cannot found cppcheck executable")
    endif()
endmacro()

# Set up static analysis with include-what-you-use
macro(enable_include_what_you_use)
    find_program(INCLUDE_WHAT_YOU_USE include-what-you-use)

    if(INCLUDE_WHAT_YOU_USE)
        message(STATUS "Enabled ${INCLUDE_WHAT_YOU_USE}")
        set(CMAKE_CXX_INCLUDE_WHAT_YOU_USE
            ${INCLUDE_WHAT_YOU_USE}
            -Xiwyu --mapping_file=${CMAKE_SOURCE_DIR}/.iwyu.imp
        )

        if(WARNINGS_AS_ERRORS)
            list(APPEND CMAKE_CXX_INCLUDE_WHAT_YOU_USE -Xiwyu --error)
        endif()
    else()
        message(WARNING "Cannot found include-what-you-use executable")
    endif()
endmacro()

# Set up static analysis with link-what-you-use
macro(enable_link_what_you_use)
    message(STATUS "Enabled link-what-you-use")
    set(CMAKE_CXX_LINK_WHAT_YOU_USE ON)
endmacro()
