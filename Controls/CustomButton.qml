import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt5Compat.GraphicalEffects

import Themes 0.1
import Texts 0.1

Button {
    id: root

    width: 150
    height: 40

    property color textColor        : ColorThemes.highEmphasisTextContrast
    property int textAlignment      : Qt.AlignLeft
    property var buttonDynamicColor : root.down ? ColorThemes.btnPressed : root.hovered
                                                ? ColorThemes.btnHovered : ColorThemes.btnDefault

    contentItem: RegularText {
        text: root.text
        color: textColor
        horizontalAlignment: textAlignment
        verticalAlignment: Qt.AlignVCenter
        elide: Qt.ElideRight
    }

    background: Rectangle {
        id: rootBG
        implicitHeight: root.height
        implicitWidth: root.width
        color: root.buttonDynamicColor
        radius: 5

        layer.enabled: root.hovered | root.down
        layer.effect: DropShadow {
            transparentBorder: true
            color: buttonDynamicColor
            samples: 10
        }
    }

    MouseArea {
        anchors.fill: parent
        enabled: false
        cursorShape: Qt.PointingHandCursor
    }
}
