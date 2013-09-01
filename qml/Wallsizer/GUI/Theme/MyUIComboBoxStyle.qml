import QtQuick 2.0
import QtQuick.Controls.Styles 1.0

import "Base"

ComboBoxStyle {
    background: BaseElement{
        implicitWidth: vars.span5
        implicitHeight: vars.gridRowHeight
        color: (control.pressed ? vars.btnBackgroundActive : over?vars.btnBackgroundHighlight:vars.btnBackground)
        colorActive: vars.btnBackgroundActive
        padding: vars.greenLight
        paddingActive: vars.green
        active: control.pressed
        over: control.hovered||control.activeFocus
        enabled: control.enabled
    }

    label: MyUILabel{
        text: control.currentText
        color: (control.pressed ? vars.lighten(vars.textColor,20) : vars.textColor)
        MyUIcon{
            icon: "sampler"
            font.pixelSize: parent.font.pixelSize
            color: parent.color
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
