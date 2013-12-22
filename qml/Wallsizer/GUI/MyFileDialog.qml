import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0
import "Theme"
Window {
    id: fileDialog
    minimumWidth: vars.span12+vars.span1
    minimumHeight: vars.column(20)
    color: vars.bodyBackground

    title: qsTr("Select Save Directory")
    modality: Qt.ApplicationModal

    signal accepted(string path)
    signal rejected()
//    signal clicked(string path)

    function open(){
        fileDialog.show();
    }

    Component.onDestruction: {
        fileDialog.rejected();
    }

    ColumnLayout {
        anchors.fill: parent
        TableView{
            id: folderTable
            backgroundVisible: false
            frameVisible: false
            activeFocusOnTab: true
            model: dirModel

            onDoubleClicked: {
                dirModel.setRootPath(dirModel.path(row))
            }

            headerDelegate: MyUITableViewStyleHeader {
            }
            rowDelegate: MyUITableViewStyleRow {
            }
            itemDelegate: MyUITableViewStyleItem {
            }
            Layout.fillWidth: true
            Layout.fillHeight: true
            TableViewColumn {
                role: "display"
                title: "Directories"
                elideMode: Text.ElideRight


            }
        }


        RowLayout {
            Layout.fillWidth: true
            Button {
                enabled: (folderTable.currentRow>-1)
                text: qsTr("Select Save Directory")
                Layout.fillWidth: true
                style: MyUIButtonStyle {
                }

                onClicked:  {
                    fileDialog.accepted(dirModel.path(folderTable.currentRow));
                    fileDialog.close();
                }

            }

        }


    }
}
