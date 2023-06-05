qt_add_library(ColorPickerLib STATIC)

set_target_properties(ColorPickerLib PROPERTIES AUTOMOC ON)
target_link_libraries(ColorPickerLib PRIVATE Qt6::Quick)

list(APPEND MODULE_QML_FILES CP.qml)

qt6_add_qml_module(ColorPickerLib
    URI ColorPickerLib
    VERSION 0.1
    RESOURCE_PREFIX /
    QML_FILES ${MODULE_QML_FILES}
    RESOURCES assets/ColorPickerLogo.png
)
