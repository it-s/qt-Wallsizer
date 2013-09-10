import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0
import QtQuick.Window 2.1

import "Theme"

Window {
    id: configWindow
    minimumWidth: vars.span12 + vars.span1
    minimumHeight: vars.column(20)
    color: vars.bodyBackground
    onVisibleChanged: {
        if (visible) {
            resolutionModel.readSettings()
            settingsSaveintoSameFolderCheckbox.checked = resolutionModel.saveSame
//            settingsAlwaysAskWhereToSaveCheckbox.checked = !resolutionModel.saveSame
//            settingsDefaultSavePath.text = resolutionModel.savePath
        }
    }

    title: qsTr("Wallsizer Settings")
    modality: Qt.ApplicationModal

//    property alias saveIntoSameFolder: settingsSaveintoSameFolderCheckbox.checked
//    property alias alwaysAskWhereToSave: settingsAlwaysAskWhereToSaveCheckbox.checked
//    property alias defaultSavePath: settingsDefaultSavePath.text

    function cleanPath(url) {
        return url.toString().replace("file:///", "")
    }
    function focusListAt(index) {
        resolutionTable.positionViewAtRow(index, ListView.Center)
        resolutionTable.currentRow = index
    }

    function startEditor(row) {
        var item = resolutionModel.resolution(row)
        console.debug(item.title)
        editWindow.itemRow = row
        editWindow.itemTitle = item.title
        editWindow.itemWidth = item.width
        editWindow.itemHeight = item.height
        editWindow.itemCompression = item.compression
        editWindow.itemLowFilter = item.detailLow
        editWindow.itemMediumFilter = item.detailMedium
        editWindow.itemHighFilter = item.detailHigh
        editWindow.itemEnabled = item.enabled
        editWindow.show()
    }


    ColumnLayout {
        id: mainLayout
        spacing: vars.em(1)
        anchors.margins: vars.column(1)
        anchors.fill: parent
        MyUIHeading {
            Layout.fillWidth: true
            text: qsTr("Image Saving")
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: vars.em(1)
            MyUILabel {
                text: qsTr("Save resulting images into the same folder as source")
                Layout.fillWidth: true
            }
            CheckBox {
                id: settingsSaveintoSameFolderCheckbox
                activeFocusOnTab: true
                style: MyUICheckBoxStyle {
                }
            }
        }
        MyUIAlert {
            Layout.fillWidth: true
            text: qsTr("New subfolder will be created inside the destination folder")
            iconName: "circle_exclamation_mark"
        }
//        RowLayout {
//            Layout.fillWidth: true
//            spacing: vars.em(1)
////            enabled: !settingsSaveintoSameFolderCheckbox.checked
//            MyUILabel {
//                text: qsTr("Always ask where to save the resulting images")
//                Layout.fillWidth: true
//            }
//            CheckBox {
//                id: settingsAlwaysAskWhereToSaveCheckbox
//                activeFocusOnTab: true
//                style: MyUICheckBoxStyle {
//                }
//            }
//        }
//        RowLayout {
//            Layout.fillWidth: true
//            enabled: !settingsSaveintoSameFolderCheckbox.checked
//                     && !settingsAlwaysAskWhereToSaveCheckbox.checked
//            TextField {
//                id: settingsDefaultSavePath
//                placeholderText: qsTr("Default save path")
//                Layout.fillWidth: true
//                readOnly: true
//                style: MyUITextFieldStyle {
//                }
//            }
//            Button {
//                id: settingsDefaultSavePathButton
//                text: qsTr("Browse")
//                iconName: "folder_open"
//                activeFocusOnTab: true
//                onClicked: fileDialog.open()
//                style: MyUIButtonStyle {
//                }
//            }
//        }
//        MyUISpacer {
//        }
        MyUIHeading {
            Layout.fillWidth: true
            text: qsTr("Image Scaling")
        }
        MyUIAlert {
            Layout.fillWidth: true
            text: qsTr("Double-click a row to edit it")
            iconName: "circle_info"
        }

        TableView {
            id: resolutionTable
            backgroundVisible: false
            frameVisible: false
            activeFocusOnTab: true
            model: resolutionModel
            headerDelegate: MyUITableViewStyleHeader {
            }
            rowDelegate: MyUITableViewStyleRow {
            }
            itemDelegate: MyUITableViewStyleItem {
            }

            Layout.fillWidth: true
            Layout.fillHeight: true
            TableViewColumn {
                role: "title"
                title: "Title"
                width: mainLayout.width - (74 * 2 + 60)
            }
            TableViewColumn {
                role: "width"
                title: "Width"
                width: 70
            }
            TableViewColumn {
                role: "height"
                title: "Height"
                width: 70
            }
            TableViewColumn {
                role: "enabled"
                title: "Use"
                width: 50
                delegate: MyUIcon {
                    icon: styleData.value ? "check" : "unchecked"
                    size: vars.baseFontSize
                    color: styleData.selected ? vars.blank : vars.textColor
                }
            }

            onActivated: startEditor(row)
            onDoubleClicked: startEditor(row)
        }

        MyUISpacer {
        }

        RowLayout {
            anchors.top: resolutionTable.bottom
            anchors.margins: 5
            spacing: 0
            Button {
                style: MyUIButtonStyle {
                }
                iconName: "circle_plus"
                activeFocusOnTab: true
                tooltip: qsTr("Add new resolution")
                onClicked: {
                    editWindow.itemRow = -1
                    editWindow.show()
                }
            }
            Button {
                style: MyUIButtonStyle {
                }
                iconName: "circle_remove"
                activeFocusOnTab: true
                tooltip: qsTr("Remove selected resolution")
                enabled: (resolutionTable.currentRow != -1)
                onClicked: resolutionModel.remove(resolutionTable.currentRow)
            }
            MyUISpacer {
            }
            Button {
                style: MyUIButtonStyle {
                }
                iconName: "edit"
                activeFocusOnTab: true
                enabled: (resolutionTable.currentRow != -1)
                onClicked: startEditor(resolutionTable.currentRow)
            }
        }
        RowLayout {
            Layout.alignment: Qt.AlignRight
            Button {
                activeFocusOnTab: true
                style: MyUIButtonStyle {
                }

                text: "Cancel"
                onClicked: configWindow.close()
            }
            Button {
                id: settingsSave
                activeFocusOnTab: true
                style: MyUIButtonStyle {
                }

                text: qsTr("Save")
                onClicked: {
                    resolutionModel.saveSame = settingsSaveintoSameFolderCheckbox.checked
//                    resolutionModel.saveAsk = settingsAlwaysAskWhereToSaveCheckbox.checked
//                    resolutionModel.savePath = settingsDefaultSavePath.text

                    resolutionModel.saveSettings()
                    configWindow.close()
                }
                isDefault: true
            }
        }
    }
    EditWindow {
        id: editWindow
        onSaveClicked: {
            console.debug(editWindow.itemRow)
            resolutionModel.update(editWindow.itemRow, data)
            if (editWindow.itemRow == -1) {
                resolutionTable.currentRow = 0
                resolutionTable.positionViewAtRow(0, ListView.Beginning)
            } else
                resolutionTable.positionViewAtRow(editWindow.itemRow,
                                                  ListView.Center)
            editWindow.close()
        }
    }
}
