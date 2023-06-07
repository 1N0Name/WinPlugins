qt_add_library(ControlsLib STATIC)

set_target_properties(ControlsLib PROPERTIES AUTOMOC ON)
target_link_libraries(ControlsLib PRIVATE Qt6::Quick)

list(APPEND MODULE_QML_FILES
    CustomButton.qml CustomCheckBox.qml CustomComboBox.qml CustomTextField.qml
    CustomToolTip.qml RoundRectangle.qml SearchBar.qml SideMenuBtn.qml
    CustomScrollBar.qml
)

qt_add_qml_module(ControlsLib
    URI Controls
    VERSION 0.1
    RESOURCE_PREFIX /
    QML_FILES ${MODULE_QML_FILES}
)
