import QtQuick 2.0
import QtQuick.Controls.Styles 1.0

import "Base"

TextFieldStyle {
    background: BaseElement {
        implicitWidth: vars.span5
        implicitHeight: vars.gridRowHeight
        color: vars.blank
        padding: vars.grayLighter
        enabled: control.enabled
        over: control.hovered||control.activeFocus
    }    
    font.family:    vars.baseFontFamily
    font.pixelSize: vars.baseFontSize
    textColor: vars.textColor
}
