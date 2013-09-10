import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.1
import "Theme"
Window {
    id:root
    width: 400
    height: 600

    TableView{
        id: folderTable
        backgroundVisible: false
        frameVisible: false
        activeFocusOnTab: true
        model: dirModel
        anchors.fill: parent
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

}
