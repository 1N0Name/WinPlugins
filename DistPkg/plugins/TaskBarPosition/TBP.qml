import QtQuick 2.15
import Qt.labs.settings 1.0

Item {
    id: tbpPlugin
    anchors.fill: parent
	
    property bool isBlue: true
	
    Settings {
        id: settings
        property alias bool: tbpPlugin.isBlue
    }

    Rectangle {
		id: rect
        anchors.fill: parent
        color: "blue"
    }
	
	Image {
	id: image
        source:                             "qrc:/assets/images/icons/logo.png"
        fillMode:                           Image.PreserveAspectFit
        mipmap:                             true

        anchors.fill:                       parent
		anchors.verticalCenter:             parent.verticalCenter
		anchors.horizontalCenter:           parent.horizontalCenter
    }
	
	RotationAnimation{
        target: image
        to: 360
        duration: 1000
        running: true
        loops: Animation.Infinite
    }
	
	MouseArea {
        anchors.fill: parent
        onClicked: {
			tbpPlugin.isBlue = !tbpPlugin.isBlue;
			rect.color = tbpPlugin.isBlue ? "blue" : "red"
		}
    }
	
	Component.onCompleted: {
		console.log(tbpPlugin.isBlue);
        rect.color = tbpPlugin.isBlue ? "blue" : "red";
    }
}
