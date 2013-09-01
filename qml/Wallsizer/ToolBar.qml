import QtQuick 2.1
import QtQuick.Controls 1.0

import "GUI/Theme"

Rectangle {
    height: vars.em(8)
    anchors.bottom: parent.pottom
    anchors.left: parent.left
    anchors.right: parent.right
    color: vars.bodyBackground

    Rectangle {
        height: 4
        gradient: Gradient {
            GradientStop {
                position: 0
                color: vars.transparent
            }

            GradientStop {
                position: 1
                color: vars.rgba(0, 0, 0, 50)
            }
        }
        anchors.bottom: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
    }

    Row {
        anchors.fill: parent
        anchors.margins: vars.paddingMini
        spacing: vars.paddingMini
        Button {
            iconName: "settings"
            width: vars.em(7)
            height: vars.em(6)
            onClicked: app.showConfig()
            style: MyUIButtonStyle {
            }
        }

        Button {
            text: qsTr("Clear")
            width: (parent.width - vars.em(7) - vars.paddingMini * 2) * 0.3
            height: vars.em(6)
            //            enabled: dropTargetArea.count>0
            onClicked: dropTargetArea.clear()
            style: MyUIButtonStyle {
            }
        }
        Button {
            text: qsTr("Process Images")
            width: (parent.width - vars.em(7) - vars.paddingMini * 2) * 0.7
            height: vars.em(6)
            //            enabled: dropTargetArea.count>0
            onClicked: {
                if (dropTargetArea.count == 0) {
                    message.show(qsTr("No images added to the drop target area. Add images first."))
                    return
                } else {
                    app.pause()
                    processInterval.start()
                }
            }
            isDefault: true
            style: MyUIButtonStyle {
            }
            Timer {
                id: processInterval
                interval: 1000
                onTriggered: app.processImages()
            }
        }
    }
}
