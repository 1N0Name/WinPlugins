import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt5Compat.GraphicalEffects

import Themes 0.1

ComboBox {
    id: root

    property color activeColor: ColorThemes.layer_05
    property color inActiveColor: ColorThemes.layer_04

    delegate: ItemDelegate {
        width: root.width - 10

        contentItem: Text {
            text: modelData
            color: root.highlightedIndex === index ? ColorThemes.highEmphasisText : ColorThemes.helperText
            font.family: "Arial"
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }

        background: Rectangle {
            width: parent.width
            height: parent.height
            color: root.highlightedIndex === index ? root.activeColor : root.inActiveColor
            radius: 5
        }
    }

    indicator: Canvas {
        id: canvas
        x: root.width - width - 10
        y: (root.availableHeight - height) / 2
        width: 12
        height: 8
        contextType: "2d"

        onPaint: {
            context.reset();
            context.moveTo(0, 0);
            context.lineTo(width, 0);
            context.lineTo(width / 2, height);
            context.closePath();
            context.fillStyle = ColorThemes.activeIcon
            context.fill();
        }

        Behavior on rotation {
            NumberAnimation {
                duration: 75
            }
        }
    }

    contentItem: Item {
        height: root.height

        Text {
            width: root.width - canvas.width - leftPadding - 5
            height: root.height
            leftPadding: 10
            verticalAlignment: Text.AlignVCenter
            text: root.displayText
            elide: Text.ElideRight

            font.pixelSize: 15
            font.family: "Arial"
            color: root.down ? ColorThemes.helperText : ColorThemes.highEmphasisText
        }
    }

    background: Rectangle {
        id: rootBG
        implicitWidth: 140
        implicitHeight: 40
        color: root.down ? root.activeColor : root.inActiveColor
        radius: 5

        layer.enabled: root.hovered | root.down
        layer.effect: DropShadow {
            transparentBorder: true
            color: root.activeColor
            samples: 10
        }
    }

    popup: Popup {
        y: root.height - 1
        width: root.width
        implicitHeight: contentItem.implicitHeight + 10
        padding: 5

        contentItem: ListView {
            implicitHeight: contentHeight
            model: root.popup.visible ? root.delegateModel : null
            clip: true
            currentIndex: root.highlightedIndex

            ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle {
            color: root.inActiveColor
            radius: 5
            clip: true

            layer.enabled: root.hovered | root.down
            layer.effect: DropShadow {
                transparentBorder: true
                color: root.inActiveColor
                samples: 10
            }
        }

        onVisibleChanged: {
            if (visible)
                canvas.rotation = 180
            else
                canvas.rotation = 0
        }
    }
}
