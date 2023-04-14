import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt5Compat.GraphicalEffects

import Themes 0.1
import Texts 0.1

ComboBox {
    id: root
    textRole: "text"

    property color activeColor: ColorThemes.layer_04
    property color inActiveColor: ColorThemes.layer_03
    property string placeholderText: ""

    currentIndex: placeholderText === "" ? 0 : -1
    displayText: currentIndex === -1 ? placeholderText : currentText

    property bool isActive: false

    delegate: ItemDelegate {
        width: root.width - 10

        property variant modelData: model

        contentItem: HelperText {
            text: modelData.text
            color: root.highlightedIndex === index ? ColorThemes.highEmphasisText : ColorThemes.helperText
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }

        background: Rectangle {
            width: parent.width
            height: parent.height
            color: root.highlightedIndex === index ? root.activeColor : root.inActiveColor
            radius: 5

            Rectangle {
                color: ColorThemes.layer_05
                visible: root.highlightedIndex === index ? true : false

                width: 3
                height: 20
                radius: 5

                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    indicator: Image {
        id: indicatorIcon
        x: root.width - width - 10
        y: (root.availableHeight - height) / 2

        source: 'qrc:/down_arrow.svg'
        sourceSize: Qt.size(12, 12)

        ColorOverlay {
            anchors.fill: indicatorIcon
            source: indicatorIcon

            color: root.down ? ColorThemes.inActiveIcon : ColorThemes.activeIcon

            antialiasing: true
        }

        Behavior on rotation {
            NumberAnimation {
                duration: 75
            }
        }
    }

    contentItem: Item {
        anchors.fill: parent

        RegularText {
            anchors.fill: parent
            leftPadding: 10
            rightPadding: indicatorIcon.width + leftPadding +10
            verticalAlignment: Text.AlignVCenter
            text: root.displayText
            elide: Text.ElideRight
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

        onVisibleChanged: visible ? indicatorIcon.rotation = 180 : indicatorIcon.rotation = 0
    }
}
