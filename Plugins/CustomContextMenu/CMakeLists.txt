qt_add_library(CustomContextMenuLib STATIC)

set_target_properties(CustomContextMenuLib PROPERTIES AUTOMOC ON)
target_link_libraries(CustomContextMenuLib PRIVATE Qt6::Quick)

list(APPEND MODULE_QML_FILES CCM.qml)

qt6_add_qml_module(CustomContextMenuLib
    URI CustomContextMenu
    VERSION 0.1
    RESOURCE_PREFIX /
    QML_FILES ${MODULE_QML_FILES}
    RESOURCES assets/customContextMenuLogo.png
)
