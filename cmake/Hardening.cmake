# Enable hardening to reduce target's surface of vulnerability
macro(
    enable_hardening
    target
    ubsan_minimal_runtime
)
    include(CheckCXXCompilerFlag)
    message(STATUS "Enabling Hardening for target ${target}")

    if(MSVC)
        list(APPEND NEW_COMPILE_OPTIONS /sdl /DYNAMICBASE /guard:cf)
        list(APPEND NEW_LINK_OPTIONS /NXCOMPAT /CETCOMPAT)
        message(STATUS "MSVC flags: /sdl /DYNAMICBASE /guard:cf /NXCOMPAT /CETCOMPAT")
    elseif(CMAKE_CXX_COMPILER_ID MATCHES ".*Clang" OR CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        list(APPEND NEW_CXX_DEFINITIONS -D_GLIBCXX_ASSERTIONS)
        message(VERBOSE "Enabled GLIBC++ Assertions (vector[], string[], ...)")

        list(APPEND NEW_COMPILE_OPTIONS -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3)
        message(VERBOSE "Enabled clang/g++ _FORTIFY_SOURCE=3")

        check_cxx_compiler_flag(-fstack-protector-strong STACK_PROTECTOR)
        if(STACK_PROTECTOR)
            list(APPEND NEW_COMPILE_OPTIONS -fstack-protector-strong)
            message(VERBOSE "Enabled clang/g++ -fstack-protector-strong")
        else()
            message(STATUS "Cannot enable clang/g++ -fstack-protector-strong")
        endif()

        check_cxx_compiler_flag(-fcf-protection CF_PROTECTION)
        if(CF_PROTECTION)
            list(APPEND NEW_COMPILE_OPTIONS -fcf-protection)
            message(VERBOSE "Enabled clang/g++ -fcf-protection")
        else()
            message(STATUS "Cannot enable clang/g++ -fcf-protection")
        endif()

        check_cxx_compiler_flag(-fstack-clash-protection CLASH_PROTECTION)
        if(CLASH_PROTECTION AND (LINUX OR CMAKE_CXX_COMPILER_ID STREQUAL "GNU"))
            list(APPEND NEW_COMPILE_OPTIONS -fstack-clash-protection)
            message(VERBOSE "Enable clang/g++ -fstack-clash-protection")
        else()
            message(STATUS "Cannot enable clang/g++ -fstack-clash-protection")
        endif()
    endif()

    if(${ubsan_minimal_runtime})
        check_cxx_compiler_flag("-fsanitize=undefined -fno-sanitize-recover=undefined -fsanitize-minimal-runtime" MINIMAL_RUNTIME)
        if(MINIMAL_RUNTIME AND CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
            list(APPEND NEW_COMPILE_OPTIONS -fsanitize=undefined -fno-sanitize-recover=undefined -fsanitize-minimal-runtime)
            list(APPEND NEW_LINK_OPTIONS -fsanitize=undefined -fno-sanitize-recover=undefined -fsanitize-minimal-runtime)
            message(VERBOSE "Enabled ubsan minimal runtime")
        else()
            message(STATUS "Cannot enable ubsan minimal runtime")
        endif()
    else()
        message(VERBOSE "Should not enable ubsan minimal runtime")
    endif()

    message(STATUS "Hardening compiler flags: ${NEW_COMPILE_OPTIONS}")
    message(STATUS "Hardening linker flags: ${NEW_LINK_OPTIONS}")
    message(STATUS "Hardening compiler definitions: ${NEW_CXX_DEFINITIONS}")

    target_compile_options(${target} INTERFACE ${NEW_COMPILE_OPTIONS})
    target_link_options(${target} INTERFACE ${NEW_LINK_OPTIONS})
    target_compile_definitions(${target} INTERFACE ${NEW_CXX_DEFINITIONS})
endmacro()
