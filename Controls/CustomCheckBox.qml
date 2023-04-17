import QtQuick 2.15
import QtQuick.Controls 2.15

import Themes 0.1
import Texts 0.1

CheckBox {
    id: root

//    indicator: Rectangle {
//        implicitWidth: root.width
//        implicitHeight: root.height

//        x: control.text ? (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding) : control.leftPadding + (control.availableWidth - width) / 2
//        y: control.topPadding + (control.availableHeight - height) / 2

//        color: control.down ? control.palette.light : control.palette.base
//        border.width: control.visualFocus ? 2 : 1
//        border.color: control.visualFocus ? control.palette.highlight : control.palette.mid

//        ColorImage {
//            x: (parent.width - width) / 2
//            y: (parent.height - height) / 2
//            defaultColor: "#353637"
//            color: control.palette.text
//            source: "qrc:/qt-project.org/imports/QtQuick/Controls/Basic/images/check.png"
//            visible: control.checkState === Qt.Checked
//        }

//        Rectangle {
//            x: (parent.width - width) / 2
//            y: (parent.height - height) / 2
//            width: 16
//            height: 3
//            color: control.palette.text
//            visible: control.checkState === Qt.PartiallyChecked
//        }
//    }

//    contentItem: RegularText {
//        color: ColorThemes.highEmphasisText
//        leftPadding: root.indicator && !root.mirrored ? root.indicator.width + root.spacing : 0
//        rightPadding: root.indicator && root.mirrored ? v.indicator.width + root.spacing : 0
//    }
}
