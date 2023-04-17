qt_add_library(TextsLib STATIC)

set_target_properties(TextsLib PROPERTIES AUTOMOC ON)
target_link_libraries(TextsLib PRIVATE Qt6::Quick)

list(APPEND MODULE_QML_FILES
    HeaderText.qml HelperText.qml RegularText.qml)

qt_add_qml_module(TextsLib
    URI Texts
    VERSION 0.1
    RESOURCE_PREFIX /
    QML_FILES ${MODULE_QML_FILES}
)
