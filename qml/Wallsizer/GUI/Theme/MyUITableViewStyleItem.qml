import QtQuick 2.0

import "Base"

Item {
    MyUILabel {
        text: styleData.value
        anchors.fill: parent
        horizontalAlignment: styleData.textAlignment
        verticalAlignment: Text.AlignVCenter
        anchors.margins: vars.em(1)
        color: styleData.selected?vars.blank:vars.textColor
        elide: Text.ElideRight
    }
}
