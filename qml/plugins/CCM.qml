import QtQuick 2.15

Item {
    id: ccmPlugin
    anchors.fill: parent

    Rectangle {
        anchors.fill: parent
        color: "red"
    }

    MouseArea {
        anchors.fill: parent
        onClicked: ccmPlugin.visible = false
    }
}
