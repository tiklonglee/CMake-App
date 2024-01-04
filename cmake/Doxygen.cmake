# Set up doxygen using a modern awesome theme
function(enable_doxygen)
    find_package(Doxygen REQUIRED OPTIONAL_COMPONENTS dot)

    cmake_language(GET_MESSAGE_LOG_LEVEL LOG_LEVEL)
    if(${LOG_LEVEL} MATCHES "(ERROR|WARNING|NOTICE|STATUS)")
        set(DOXYGEN_QUIET YES)
    endif()

    set(DOXYGEN_EXTRACT_ALL YES)
    set(DOXYGEN_CALL_GRAPH YES)
    set(DOXYGEN_CALLER_GRAPH YES)
    set(DOXYGEN_DOT_IMAGE_FORMAT svg)
    set(DOXYGEN_EXCLUDE_PATTERNS "*/_deps/*")

    # use doxygen-awesome-css theme
    include(FetchContent)
    FetchContent_Declare(
        doxygen-awesome-css
        GIT_REPOSITORY https://github.com/jothepro/doxygen-awesome-css.git
        GIT_TAG v2.3.1
    )
    FetchContent_MakeAvailable(doxygen-awesome-css)

    set(DOXYGEN_GENERATE_TREEVIEW YES)
    set(DOXYGEN_HTML_COLORSTYLE LIGHT)
    set(DOXYGEN_THEME "awesome" CACHE STRING "Custom doxygen theme to be used")
    set_property(CACHE DOXYGEN_THEME PROPERTY STRINGS "awesome" "awesome-sidebar")
    if(${DOXYGEN_THEME} STREQUAL "awesome")
        set(DOXYGEN_HTML_EXTRA_STYLESHEET "${doxygen-awesome-css_SOURCE_DIR}/doxygen-awesome.css")
    elseif(${DOXYGEN_THEME} STREQUAL "awesome-sidebar")
        set(DOXYGEN_HTML_EXTRA_STYLESHEET "${doxygen-awesome-css_SOURCE_DIR}/doxygen-awesome.css"
                                          "${doxygen-awesome-css_SOURCE_DIR}/doxygen-awesome-sidebar-only.css")
    endif()

    doxygen_add_docs(
        doxygen
        ${PROJECT_SOURCE_DIR} ALL
        COMMENT "Generate HTML documentation: ${CMAKE_CURRENT_BINARY_DIR}/html/index.html"
    )
endfunction()
