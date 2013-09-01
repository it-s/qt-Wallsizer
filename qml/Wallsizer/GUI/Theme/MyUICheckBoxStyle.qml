import QtQuick 2.0
import QtQuick.Controls.Styles 1.0

import "Base"

CheckBoxStyle {
    indicator: BaseElement {
        implicitWidth: vars.span2
        implicitHeight: vars.gridRowHeight
        anchors.right: parent.right
        color: vars.gray
        colorActive: vars.green
        padding: vars.grayLighter
        paddingActive: vars.grayLighter
        active: control.checked
        over: control.hovered || control.activeFocus
        enabled: control.enabled

        MyUIcon {
            icon: "ok"
            width: vars.gridRowHeight
            height: width
            anchors.left: parent.left
            color: vars.blank
            font.pixelSize: vars.fontSizeMedium
        }
        MyUIcon {
            icon: "remove"
            width: vars.gridRowHeight
            height: width
            anchors.right: parent.right
            color: vars.blank
            font.pixelSize: vars.fontSizeMedium
        }

        Behavior on color {
            ColorAnimation {
            }
        }
        Rectangle {
            x: active ? (parent.width / 2) : 0
            y: 0
            width: parent.width / 2
            height: vars.gridRowHeight
            radius: vars.borderRadiusLarge
            color: {
                var c = active && enabled ? vars.greenLight : vars.grayLight
                return parent.enabled ? c : vars.lighten(c, 10)
            }
            enabled: control.enabled
            Behavior on x {
                NumberAnimation {
                }
            }
            Behavior on color {
                ColorAnimation {
                }
            }
        }
    }
    label: Item {
    }
}
