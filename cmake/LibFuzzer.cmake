# Check whether fuzzer sanitizer are available
function(check_libfuzzer_support var_name)
    set(LibFuzzerTestSource
    "
    #include <cstddef>
    #include <cstdint>

    extern \"C\" int LLVMFuzzerTestOneInput(const uint8_t* data, size_t size) { return 0; }
    ")

    include(CheckCXXSourceCompiles)

    if(CMAKE_CXX_COMPILER_ID MATCHES ".*Clang")
        set(CMAKE_REQUIRED_FLAGS "-fsanitize=fuzzer")
        set(CMAKE_REQUIRED_LINK_OPTIONS "-fsanitize=fuzzer")
        check_cxx_source_compiles("${LibFuzzerTestSource}" ${var_name})
    endif()
endfunction()
