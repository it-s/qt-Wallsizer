import QtQuick 2.2

import "GUI/Theme"

Rectangle {
    id: indicatorOverlayBase
    width: 100
    height: 62
    opacity: 0
    color: vars.transparent
    function show(type){
        state = type;
    }

    function hide(){
        state = "";
    }

    function isShown(type){
        if(type==undefined)return state!="";
        return state==type;
    }

//    Timer{
//        id: messageTimer
//        running: false
//        triggeredOnStart: false
//        repeat: false
//        interval: 5000
//        onTriggered: indicatorOverlayBase.hide()
//    }

    MyUIcon{
        id: icon
        icon: ""
        size: vars.fontSizeHuge
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    states: [
        State {
            name: "ACCEPT"
            when: dropTargetArea.state==0

            PropertyChanges {
                target: indicatorOverlayBase
                color: vars.rgba(150,173,201,120)
                opacity: 1
            }

            PropertyChanges {
                target: icon
                icon: "inbox_in"
                color: vars.blank
                styleColor: vars.blue
                style: Text.Sunken
            }
        },
        State {
            name: "REJECT"
            when: dropTargetArea.state>0

            PropertyChanges {
                target: indicatorOverlayBase
                color: vars.rgba(347,126,227,120)
                opacity: 1
            }

            PropertyChanges {
                target: indicatorOverlayBase
                opacity: 1
            }

            PropertyChanges {
                target: icon
                icon: "inbox_minus"
                color: vars.blank
                styleColor: vars.red
                style: Text.Sunken
            }

//            PropertyChanges {
//                target: messageTimer
//                running: true
//            }
        },
        State {
            name: "DROPZONE"
            when: parent.count==0&&
                  dropTargetArea.state<0

            PropertyChanges {
                target: indicatorOverlayBase
                opacity: 1
            }

            PropertyChanges {
                target: indicatorOverlayBase
                opacity: "1"
            }

            PropertyChanges {
                target: icon
                icon: "download_alt"
                styleColor: "#fff"
                style: Text.Raised
            }
        },
        State {
            name: "PROCESS"
            PropertyChanges {
                target: indicatorOverlayBase
                color: vars.rgba(0,0,0,100)
                opacity: "1"
            }

            PropertyChanges {
                target: indicatorOverlayBase
                opacity: "1"
            }

            PropertyChanges {
                target: icon
                icon: "clock"
                color: vars.blank
                styleColor: "#000"
                style: Text.Sunken
            }
        }
    ]
    transitions: [
        Transition {
            from: ""
            to: "ACCEPT"
            reversible: true
            NumberAnimation { property: "opacity"}
            ColorAnimation{}
        },
        Transition {
            from: ""
            to: "REJECT"
            reversible: true
            NumberAnimation { property: "opacity"}
            ColorAnimation{}
        },
        Transition {
            from: ""
            to: "PROCESS"
            reversible: true
            NumberAnimation { property: "opacity"}
            ColorAnimation{}
        },
        Transition {
            from: "ACCEPT"
            to: "REJECT"
            reversible: true
            ColorAnimation{}
        },
        Transition {
            from: ""
            to: "DROPZONE"
            reversible: true
            NumberAnimation { property: "opacity"}
            ColorAnimation{}
        }
    ]
}
