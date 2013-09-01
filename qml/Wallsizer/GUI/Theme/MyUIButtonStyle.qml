import QtQuick 2.0
import QtQuick.Controls.Styles 1.0

import "Base"

ButtonStyle {
    background: BaseElement {
        implicitWidth: control.text==""?vars.em(5):vars.span3
        implicitHeight: vars.gridRowHeight
        color: (control.pressed ? vars.btnBackgroundActive : over?vars.btnBackgroundHighlight:vars.btnBackground)
        colorActive: vars.btnBackgroundActive
        padding: control.isDefault ? vars.btnPrimaryBackground : vars.gray
        paddingActive: vars.blank
        active: control.pressed
        over: control.hovered||control.activeFocus
        enabled: control.enabled
    }
    label: Item {
        MyUIcon{
            id: alertIcon
            x: control.text.length>0?vars.em(1)*(control.iconName.length>0?1:0):control.width/2-width/1.5
            anchors.verticalCenter: parent.verticalCenter
            color: text.color
            icon: control.iconName
            font.pixelSize: control.text.length>0?text.font.pixelSize:vars.fontSizeMedium
            opacity: text.opacity
        }

        MyUILabel {
            id: text
            text: control.text
            anchors.left: alertIcon.right
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            wrapMode: Text.WordWrap
            anchors.margins: vars.em(1)
            color: (control.pressed ? vars.lighten(vars.textColor,20) : vars.textColor)
            opacity: control.enabled ? 1 : 0.5
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
