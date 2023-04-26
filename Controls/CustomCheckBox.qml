import QtQuick 2.15
import QtQuick.Controls 2.15

import Themes 0.1
import Texts 0.1

CheckBox {
    id: root

    indicator: Rectangle {
        id: indicator
        implicitWidth: 20
        implicitHeight: 20
        color: "#00ffffff"
        border.color: ColorThemes.activeIcon
        radius: 5

        Image {
            id: tick
            source: "qrc:/tick.svg"
            sourceSize: Qt.size(indicator.implicitWidth, indicator.implicitHeight)
            antialiasing: true
        }

        PropertyAnimation {
            target: tick
            property: "opacity"
            from: 1
            to: 0
            duration: 500
        }
    }

    contentItem: RegularText {
        text: root.text
        color: ColorThemes.highEmphasisText
        leftPadding: root.indicator && !root.mirrored ? root.indicator.width + root.spacing : 0
        rightPadding: root.indicator && root.mirrored ? v.indicator.width + root.spacing : 0
    }
}
