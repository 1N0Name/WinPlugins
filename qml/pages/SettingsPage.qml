import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

import Themes 0.1
import Texts 0.1
import Controls 0.1

RoundRectangle {
    id: background
    color: ColorThemes.layer_02
    radius: 10
    radiusCorners: Qt.AlignLeft | Qt.AlignTop

    ColumnLayout {
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.topMargin: 20
        anchors.bottomMargin: 10

        spacing: 10

        HeaderText {
            text: qsTr("Выберите тему")
            color: ColorThemes.highEmphasisText
            elide: Text.ElideRight

            verticalAlignment: Text.AlignVCenter
            Layout.preferredWidth: 3
            Layout.fillWidth: true
        }

        ButtonGroup {
            id: themeRG
            exclusive: true
        }

        RadioButton {
            text: qsTr("Light")

            contentItem: Text {
                text: parent.text
                color: ColorThemes.helperText
                leftPadding: parent.indicator.width + parent.spacing
                verticalAlignment: Text.AlignVCenter
            }

            ButtonGroup.group: themeRG
            onClicked: {
                ColorThemes.currentTheme = ColorThemes.themes.light
            }
        }

        RadioButton {
            text: qsTr("Dark")
            checked: true

            contentItem: Text {
                text: parent.text
                color: ColorThemes.helperText
                leftPadding: parent.indicator.width + parent.spacing
                verticalAlignment: Text.AlignVCenter
            }

            ButtonGroup.group: themeRG
            onClicked: {
                ColorThemes.currentTheme = ColorThemes.themes.dark
            }
        }

        HeaderText {
            text: qsTr("Выберите язык")
            color: ColorThemes.highEmphasisText
            elide: Text.ElideRight

            verticalAlignment: Text.AlignVCenter
            Layout.preferredWidth: 3
            Layout.fillWidth: true
        }

        CustomComboBox {
            model: ListModel {
                id: model
                ListElement { text: "Русский" }
                ListElement { text: "English" }
            }
        }

        Item {
            Layout.fillHeight: true
        }
    }
}

