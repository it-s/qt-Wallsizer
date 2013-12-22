import QtQuick 2.2
import "GUI/Theme"
Item{
    id: imageFrame
    property alias imageSource: image.source
    signal removed;

    Rectangle {
        anchors.fill: parent
        anchors.margins: 4
        color: vars.blank

        AnimatedImage{
            id: loader
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            source: "images/ajax-loader.gif"
            playing: image.status==Image.Loading
            visible: playing
        }

        Image {
            id: image
            anchors.fill: parent
            anchors.margins: 5
            asynchronous: true
            fillMode: Image.PreserveAspectCrop
        }

        MouseArea{
            id: sensor
            hoverEnabled: true
            anchors.fill: parent

        }

        Rectangle {
            width: vars.fontSizeHuge
            height: width
            radius: width/2

            enabled: sensor.containsMouse
            visible: enabled

            color: vars.black

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            MyUIcon {
                icon: "remove"
                size: vars.fontSizeLarge
                color: vars.white
                scale: buttonSensor.pressed ? 0.8 : 1
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                Behavior on scale {
                    NumberAnimation {
                        duration: 500
                        easing.type: Easing.OutElastic
                    }
                }
            }
            MouseArea{
                id: buttonSensor
                anchors.fill: parent
                onClicked: imageFrame.removed()
            }
        }
    }
}
