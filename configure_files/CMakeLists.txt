find_program(GIT_PATH git REQUIRED)
execute_process(
    COMMAND ${GIT_PATH} log --pretty=format:'%H' -n 1
    OUTPUT_VARIABLE GIT_SHA
)
string(TIMESTAMP TIMESTAMP)

configure_file(version.hpp.in ${CMAKE_BINARY_DIR}/configure_files/include/configure_files/version.hpp @ONLY)
