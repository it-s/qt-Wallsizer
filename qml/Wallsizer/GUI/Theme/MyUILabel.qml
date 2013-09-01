import QtQuick 2.0
//import QtQuick.Controls 1.0
import "Base"
BaseText {
    color: enabled ? vars.textColor : vars.lighten(vars.textColor,40)
    wrapMode: Text.WordWrap
    verticalAlignment: Text.AlignTop
}
