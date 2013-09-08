import QtQuick 2.0

import "Base"

Rectangle {
    property int columns: 0
    property bool isFirst: styleData.column == 0
    property bool isLast: styleData.column == columns

    implicitWidth: vars.span3
    implicitHeight: vars.gridRowHeight
    height: vars.span1
    radius: vars.baseBorderRadius
    color: (styleData.pressed ? vars.seaLight : vars.sea)

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        height: vars.em(0.2)
        color: vars.white
    }

    BaseText {
        id: text
        text: styleData.value
        anchors.fill: parent
        anchors.margins: vars.em(1)
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        color: (styleData.pressed ? vars.white : vars.blank)
    }
}
