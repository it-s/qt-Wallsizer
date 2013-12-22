import QtQuick 2.2
import QtQuick.Dialogs 1.1
import QtQuick.Controls 1.1
import com.Likalo.MyThread 1.0

import "GUI/Theme/Fonts"
import "GUI/Theme"
import "GUI"

ApplicationWindow {
    id: app
    title: "Wallsizer"
    visible: true
    minimumWidth: 400
    minimumHeight: 360
    width: 420
    height: 400


    function showIntro() {
        message.show(qsTr("Drag and drop images you wish to resize onto the window drop target"),
                     999999)
    }

    function showConfig() {
        if (!configWindow.visible)
            configWindow.show()
    }

    Fonts {
    }
    Variables {
        id: vars
    }
    Component.onCompleted: showIntro()

    Image {
        anchors.fill: parent
        fillMode: Image.Tile
        source: "images/diagonal-noise.png"
    }

    DropTargetArea {
        id: dropTargetArea
        anchors.bottom: toolbar.top
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        onCleared: showIntro()

        IndicatorOverlay {
            id: indicator
            anchors.fill: parent
        }
        MessageOverlay {
            id: message
        }
    }

    MyToolBar {
        id: toolbar
        color: "#eef1f2"
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        onClearClicked: dropTargetArea.clear()
        onProcessClicked:  fileDialog.open();
    }

    ConfigWindow {
        id: configWindow
    }

    MyThread {
        id: myThread
        onStarted: {
            indicator.show("PROCESS")
        }
        onFinished: {
            indicator.hide()
        }
    }

//    FileDialog{
//        id:fileDialog
//        title: "Please choose a save path"
//        selectFolder: true
//        selectExisting: true
//        onAccepted:{
//            console.log("Save path accepted "+url);
////            if(dropTargetArea.count>0){
////                myThread.setDestination(path)
////                myThread.setUrls(dropTargetArea.urls)
////                myThread.start()
////        }
//        }
//        onRejected: {
//            console.log("Save path rejected")
//        }
//    }

    MyFileDialog {
        id:fileDialog
        onAccepted:{
            console.log("Save path accepted "+path);
            if(dropTargetArea.count>0){
                myThread.setDestination(path)
                myThread.setUrls(dropTargetArea.urls)
                myThread.start()
            }
            else message.show(qsTr("No images to process.\nPlease add some images first."))
        }
        onRejected: {
            console.log("Save path rejected")
        }
    }

}
