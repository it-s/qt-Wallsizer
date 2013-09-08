import QtQuick 2.0

Rectangle {
    property int rows: 0
    property bool isFirst: styleData.row == 0
    property bool isLast: styleData.row == rows

    implicitWidth: vars.span3
    implicitHeight: vars.span1
    height: vars.span1
    color: (styleData.pressed||styleData.selected ? vars.blueLight :vars.blank)

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        height: vars.em(0.2)
        color: vars.white
    }
}
