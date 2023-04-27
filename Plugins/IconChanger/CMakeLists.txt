qt_add_library(IconChangerLib STATIC)

set_target_properties(IconChangerLib PROPERTIES AUTOMOC ON)
target_link_libraries(IconChangerLib PRIVATE Qt6::Gui PRIVATE Qt6::Quick)

list(APPEND MODULE_QML_FILES IconChanger.qml)

list(APPEND HPP_SOURCES iconmodel.h)

list(APPEND CPP_SOURCES iconmodel.cpp)

list(APPEND ICON_RESOURCES assets/iconChangerLogo.png assets/folder.svg assets/delete.svg
    assets/icon.svg IconRepository/API.ico IconRepository/billy-herrington.ico
    IconRepository/docs.ico IconRepository/music.ico)

qt_add_qml_module(IconChangerLib
    URI IconChanger
    VERSION 0.1
    RESOURCE_PREFIX /
    QML_FILES ${MODULE_QML_FILES}
    RESOURCES ${ICON_RESOURCES}
    SOURCES iconmodel.h iconmodel.cpp
)
