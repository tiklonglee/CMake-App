set(FUZZ_RUNTIME 10 CACHE STRING "Number of seconds to run fuzz tests during ctest run")

add_subdirectory(core_fuzz_test)
