import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.1
import "Theme"
Window {
    id:root
    width: 500
    height: 600
    signal clicked(string path)

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
                title: "name"


            }
        }


        RowLayout {
            Layout.fillWidth: true
            Button {
                text: qsTr("Select")
                Layout.fillWidth: true
                style: MyUIButtonStyle {
                }

                onClicked:  {
                    root.close();
                    root.clicked(dirModel.path(folderTable.currentRow))
                }

            }

        }


    }
}
