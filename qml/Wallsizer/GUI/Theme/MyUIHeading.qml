import QtQuick 2.0
//import QtQuick.Controls 1.0
import "Base"

BaseText {
    color: enabled ? vars.headingsColor : vars.lighten(vars.headingsColor, 50)
    font.family: vars.headingsFontFamily
    font.pixelSize: vars.fontSizeLarge
    //    smooth: true
}
