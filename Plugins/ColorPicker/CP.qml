import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt.labs.platform 1.1
import Qt5Compat.GraphicalEffects

import Themes 0.1
import Texts 0.1

//import "../controls"

Rectangle {
    id: background
    color: ColorThemes.layer_02

    Rectangle {
        color: ColorThemes.layer_01
        radius: 10

        anchors.fill: parent
        anchors.topMargin: 30
        anchors.bottomMargin: 30
        anchors.leftMargin: 200
        anchors.rightMargin: 200

        ColumnLayout {
            spacing: 10

            anchors.fill: parent
            anchors.margins: 10

            HeaderText {
                text: qsTr("IconChanger")
                color: ColorThemes.highEmphasisText
                Layout.fillWidth: true
                horizontalAlignment: Qt.AlignHCenter
            }
        }
    }
}
