import QtQuick 2.0
import QtQuick.Controls 1.0

Label {
    wrapMode: Text.WordWrap
    font.family: vars.iconsFontFamily
    font.pixelSize: size
    lineHeight: 1
    text: vars.getIconCode(icon)
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
    clip: true
    property string icon: "glass_icon"
    property double size: vars.fontSizeNormal
    smooth: true
}
