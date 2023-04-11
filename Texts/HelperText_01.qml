import QtQuick 2.15
import QtQuick.Controls 2.15

Text {
    id: root

    property bool clickable: false
    property bool containsMouse

    // Tooltip
    property bool tooltipEnabled: false
    property string tooltipText: text

    signal clicked

    font.family: "Segoe UI"
    font.pixelSize: 12

    ToolTip.text: tooltipText
    ToolTip.visible: tooltipText != "" && tooltipEnabled && containsMouse

    Loader {
        id: mouseAreaLoader
        anchors.fill: parent
        sourceComponent: mouseAreaComponent
        active: root.clickable || root.tooltipEnabled
    }

    Component {
        id: mouseAreaComponent

        MouseArea{
            id: mouseArea
            hoverEnabled: true
            cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
            onClicked: {
                if(root.clickable)
                    root.clicked();
            }
            onContainsMouseChanged: root.containsMouse = containsMouse;
        }
    }
}
