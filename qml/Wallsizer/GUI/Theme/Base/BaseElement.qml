import QtQuick 2.0
import ".."

Item {
    property bool enabled: true
    property bool over: false
    property bool active: false
    property color color: vars.blank
    property color colorActive: vars.grayLighter
    property alias border: container.border
    property color padding: vars.gray
    property color paddingActive: vars.grayDark
    Rectangle {
        id: border
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.over?(vars.em(0.4) * -1):(vars.em(0.2) * -1)
        height: vars.em(0.6)
        color: {
            var c = parent.active&&parent.enabled?parent.paddingActive:parent.padding;
            return parent.enabled?c:vars.lighten(c,20);
        }
    }
    Rectangle {
        id: container
        width: parent.width
        height: parent.height
        radius:                 vars.borderRadiusLarge
        color: {
            var c = parent.active&&parent.enabled?parent.colorActive:parent.color;
            return parent.enabled?c:vars.lighten(c,20);
        }
    }
}
