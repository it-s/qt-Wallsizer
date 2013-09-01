import QtQuick 2.0
import QtQuick.Controls.Styles 1.0

SliderStyle {

    groove:Rectangle{
        color: vars.grayLighter
        implicitWidth: vars.span12
        implicitHeight: vars.em(0.8)
        radius: vars.baseBorderRadius
        property int _setSize: Math.floor((control.maximumValue-control.minimumValue)/control.stepSize)+1
        Repeater{
            model: control.tickmarksEnabled?_setSize:0
            Rectangle{
                property int padding:  Math.floor(vars.em(2.5)/2-width/2)
                property int value: Math.floor((control.value-control.minimumValue)/control.stepSize)
                x: padding + index*(control.width-padding/2)/_setSize
//                y: -width/4
                width: vars.em(0.5)
                height: width
                radius: width/2
                color: vars.grayLight
                anchors.verticalCenter: parent.verticalCenter
//                color: value<index?vars.grayLight:vars.green
            }
        }
    }
    handle: Rectangle{
        anchors.centerIn: parent
        color: control.pressed||control.focus ? vars.greenLight : vars.green
        width: vars.em(2.5)
        height: width
        radius: width/2
        Rectangle{
            width: vars.em(1)
            height: width
            radius: width/2
            color: control.pressed ? vars.green : vars.greenLight
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
