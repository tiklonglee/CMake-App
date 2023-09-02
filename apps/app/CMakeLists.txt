add_executable(app app.cpp)

target_link_libraries(
    app
    PRIVATE
        ${PROJECT_NAME}::default_interface
        ${PROJECT_NAME}::core
)
