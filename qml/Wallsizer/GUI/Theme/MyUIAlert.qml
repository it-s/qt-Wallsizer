import QtQuick 2.0
import "Base"

Item {
    id: alert
    width: vars.span12
    height: alertText.lineCount==1?vars.gridRowHeight:alertText.lineCount * vars.em(2) + alertText.lineCount * vars.em(
                1) + vars.em(2)
//    color: vars.lighten(vars.green,70)

//    property color colorBorder: vars.sea
    property alias colorText: alertText.color
//    radius: vars.baseBorderRadius
//    border.color: vars.darken(color,10)
//    border.width: 1

    property alias text: alertText.text
    property alias iconName: alertIcon.icon

    MyUIcon {
        id: alertIcon
        anchors.left: parent.left
        anchors.top: alertText.top
        anchors.leftMargin: vars.em(1)
        enabled: parent.enabled
        color: alertText.color
    }

    BaseText {
        id: alertText
        text: qsTr("Alert sample text")
        anchors.left: alertIcon.right
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        wrapMode: Text.WordWrap
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        anchors.margins: vars.em(1)
        enabled: parent.enabled
        color: vars.labelColor
    }

}
