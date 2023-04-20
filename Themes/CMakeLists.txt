qt_add_library(ThemesLib STATIC)

set_target_properties(ThemesLib PROPERTIES AUTOMOC ON)
target_link_libraries(ThemesLib PRIVATE Qt6::Quick)

list(APPEND MODULE_QML_FILES ColorThemes.qml)

set_source_files_properties(${MODULE_QML_FILES} PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)

qt_add_qml_module(ThemesLib
    URI Themes
    VERSION 0.1
    RESOURCE_PREFIX /
    QML_FILES ${MODULE_QML_FILES}
)
