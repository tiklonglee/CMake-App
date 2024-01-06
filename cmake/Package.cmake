include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

function(configure_base_package)
    configure_package_config_file(
        ${PROJECT_SOURCE_DIR}/cmake/Config.cmake.in
        ${PROJECT_BINARY_DIR}/cmake/${PROJECT_NAME}Config.cmake
        INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}
        PATH_VARS CMAKE_INSTALL_LIBDIR
    )
    write_basic_package_version_file(
        ${PROJECT_BINARY_DIR}/cmake/${PROJECT_NAME}ConfigVersion.cmake
        COMPATIBILITY SameMajorVersion
    )
    install(
        FILES
            ${PROJECT_BINARY_DIR}/cmake/${PROJECT_NAME}Config.cmake
            ${PROJECT_BINARY_DIR}/cmake/${PROJECT_NAME}ConfigVersion.cmake
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}
    )
endfunction()

function(library_package)
    set(options "")
    set(one_value_args COMPONENT)
    set(multi_value_args TARGETS)
    cmake_parse_arguments(LibraryPackage "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})

    install(
        TARGETS ${LibraryPackage_TARGETS}
        EXPORT ${PROJECT_NAME}${LibraryPackage_COMPONENT}Targets
        COMPONENT ${LibraryPackage_COMPONENT}
        PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${LibraryPackage_COMPONENT}
        FILE_SET HEADERS
    )
    install(
        EXPORT ${PROJECT_NAME}${LibraryPackage_COMPONENT}Targets
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}
        NAMESPACE ${PROJECT_NAME}::
        FILE ${PROJECT_NAME}${LibraryPackage_COMPONENT}Targets.cmake
        COMPONENT ${LibraryPackage_COMPONENT}
    )
endfunction()

function(application_package)
    set(options "")
    set(one_value_args "")
    set(multi_value_args TARGETS)
    cmake_parse_arguments(ApplicationPackage "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})

    install(
        TARGETS ${ApplicationPackage_TARGETS}
    )
endfunction()
