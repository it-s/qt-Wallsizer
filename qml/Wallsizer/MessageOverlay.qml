import QtQuick 2.1

import "GUI/Theme/Base"

Rectangle {
    id: messageBody
    width: vars.span12
    height: vars.span2
    clip: true

    anchors.bottomMargin: 0
    anchors.right: parent.right
    anchors.left: parent.left
    anchors.bottom: parent.top

    color: vars.rgba(0,0,0,150)

    function isShown(){
        return state=="SHOW";
    }

    function show(message,duration){
        if(duration!==undefined)timeout = duration;
        else timeout = 5000;
        text = message;
        messageText.visible = true;
        state = "SHOW";
        messageTimer.running = true;
    }

    function hide(){
        messageTimer.running = false;
        state = "";
    }

    property alias text: messageText.text
    property alias timeout: messageTimer.interval

    Timer{
        id: messageTimer
        running: false
        triggeredOnStart: false
        repeat: false
        interval: 5000
        onTriggered: messageBody.hide()
    }

    BaseText {
        id: messageText
        color: vars.blank
        text: "Text"
        wrapMode: Text.WordWrap
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.family: "sans"
        anchors.fill: parent
        anchors.margins: vars.em(2)
    }
    states: [
        State {
            name: "SHOW"
            PropertyChanges { target: messageBody; anchors.bottomMargin: -height }
        }
    ]
    transitions: [
        Transition {
            from: ""
            to: "SHOW"
            reversible: true
            NumberAnimation{property: "anchors.bottomMargin"}
        }
    ]
}
