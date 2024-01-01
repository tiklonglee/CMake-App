add_executable(core_fuzz_test core_fuzz_test.cpp)

target_link_libraries(
    core_fuzz_test
    PRIVATE
        ${PROJECT_NAME}::default_interface
        ${PROJECT_NAME}::core
)

target_compile_options(core_fuzz_test PRIVATE -fsanitize=fuzzer,address,undefined --coverage)
target_link_options(core_fuzz_test PRIVATE -fsanitize=fuzzer,address,undefined --coverage)

add_test(NAME core_fuzz_test_run COMMAND core_fuzz_test -max_total_time=${FUZZ_RUNTIME})
