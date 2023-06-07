import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt5Compat.GraphicalEffects

import Themes 0.1
import Texts 0.1

CheckBox {
    id: root

    indicator: Rectangle {
        id: indicator
        implicitWidth: 20
        implicitHeight: 20
        color: root.checkState === Qt.Checked ? ((ColorThemes.currentTheme == ColorThemes.themes.dark) ?
                                                     ColorThemes.btnDefault : "#5053b5"): "#00ffffff"
        border.color: root.checkState === Qt.Checked ? "#00ffffff" :
                                ((ColorThemes.currentTheme == ColorThemes.themes.dark) ? "#dedede" : "#616161")
        radius: 5

        anchors.verticalCenter: parent.verticalCenter

        Image {
            id: tick
            source: "qrc:/tick.svg"
            sourceSize: Qt.size(indicator.implicitWidth, indicator.implicitHeight)
            antialiasing: true
            visible: root.checkState === Qt.Checked
        }

        ColorOverlay {
            anchors.fill: tick
            source: tick
            color: (ColorThemes.currentTheme == ColorThemes.themes.dark) ? "#1d1d33" : "#ebebf4"
            antialiasing: true
            visible: root.checkState === Qt.Checked
        }

        PropertyAnimation {
            target: tick
            property: "opacity"
            from: 1
            to: 0
            duration: 800
        }
    }

    contentItem: RegularText {
        id: innerText
        text: root.text
        color: ColorThemes.highEmphasisText

        leftPadding: root.indicator.width
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        verticalAlignment: Text.AlignVCenter
    }
}
