cmake_minimum_required(VERSION 3.16)

set(EXECUTABLE_NAME "WinPlugins")

project(${EXECUTABLE_NAME} VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 COMPONENTS Gui Quick QuickControls2 Core REQUIRED)

add_subdirectory(Themes)
add_subdirectory(Texts)
add_subdirectory(Controls)

qt_standard_project_setup(REQUIRES 6.5)

# Include all image references
qt_add_resources(IMAGE_RESOURCES images.qrc)

# Collect all the source files in the project and library
file(GLOB CPP_SOURCES lib/*.cpp tests/*.cpp main.cpp)
file(GLOB HPP_SOURCES lib/*.h tests/*.h)

# Set app icon
set (WIN32_ICON ${CMAKE_CURRENT_SOURCE_DIR}/assets/WinPlugins.rc)

qt_add_executable(${EXECUTABLE_NAME}
   ${HPP_SOURCES}
   ${CPP_SOURCES}
   ${IMAGE_RESOURCES}
   ${WIN32_ICON}
)

# Group all source files in the project
file(GLOB QML_SOURCES RELATIVE ${CMAKE_SOURCE_DIR} qml/*.qml qml/pages/*.qml)
source_group("Qml Files" FILES ${QML_SOURCES})

qt_add_qml_module(${EXECUTABLE_NAME}
    URI ${EXECUTABLE_NAME}
    RESOURCE_PREFIX /
    VERSION 0.1
    QML_FILES ${QML_SOURCES}
)

set_target_properties(${EXECUTABLE_NAME} PROPERTIES
    MACOSX_BUNDLE FALSE
    WIN32_EXECUTABLE TRUE
)

# Debug conf.
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    # Define debug constants
    target_compile_definitions(${EXECUTABLE_NAME} PRIVATE PR_DEBUG)

    # Copy plugins conf. to the binary dir.
    add_custom_target(copy_plugins ALL
        COMMAND ${CMAKE_COMMAND} -E copy_directory
        ${PROJECT_SOURCE_DIR}/Plugins
        ${PROJECT_BINARY_DIR}/plugins
        DEPENDS ${MY_TARGET})

    file(GLOB PLUGIN_DIRECTORIES RELATIVE ${CMAKE_SOURCE_DIR} Plugins/*)
    foreach(DIR ${PLUGIN_DIRECTORIES})
        if(IS_DIRECTORY ${DIR})
            message(STATUS "DIR - ${DIR}")
            add_subdirectory(${DIR})
        endif()
    endforeach()
endif()

target_link_libraries(${EXECUTABLE_NAME}
    PRIVATE Qt6::Core
    PRIVATE Qt6::Gui
    PRIVATE Qt6::Quick
    PRIVATE Qt6::QuickControls2   
    PRIVATE ThemesLibplugin
    PRIVATE TextsLibplugin
    PRIVATE ControlsLibplugin
    PRIVATE IconChangerLibplugin
    PRIVATE CustomContextMenuLibplugin
    PRIVATE ColorPickerLibplugin
)

install(TARGETS ${EXECUTABLE_NAME}
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
)
