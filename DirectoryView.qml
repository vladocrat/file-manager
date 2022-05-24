import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt.labs.folderlistmodel 2.0
import filesystembrowser 1.0
import QtQml.Models 2.2
import BrowseController 1.0

Rectangle {
    id: root

    signal itemSelected(var name, var size, var creationDate, var isFolder, var sizeUnits);
    signal createFolderFile(var msg, var isFolder);
    signal showPopupMessage(var msg);

    property bool isItemSelected: false
    property string copyUrl: ""

    color: "white"
    border.width: 1

    ContextMenue {
        id: contextMenu

        ContextMenuItem {
            text: "New folder"

            onTriggered: root.createFolderFile("enter folder name", true);
        }

        ContextMenuItem {
            text: "New file"

            onTriggered: root.createFolderFile("enter file name", false);
        }

        ContextMenuItem {
            text: "paste"
            enabled: contextMenu.pasteState

            onTriggered: {
                var pasteUrl = BrowseController.current
                console.log("pasteUrl: " + pasteUrl);
                console.log("copyUrl: " + root.copyUrl);
                var index = folderModel.indexOf(root.copyUrl);
                if (!ActionController.copyFolderFile(copyUrl, pasteUrl)) {
                    root.showPopupMessage("failed to copy");
                }

                root.pasteState = true;
            }
        }
    }

    DelegateModel {
        id: visualModel

        model: FolderListModel {
            id: folderModel

            folder: BrowseController.current
            showDirsFirst: true
        }

        delegate: DirectoryViewDelegate {
            width: listView.width
            height: 40

            onShowPopupMessage: {
                root.showPopupMessage(msg);
            }

            onCopyUrlChanged: {
                root.copyUrl = url;
                contextMenu.pasteState = true;
            }

            onCurrentIndexChanged: {
                listView.currentIndex = index;
            }

            onMouseEntered: {
                mouseArea.enabled = false;
            }

            onMouseExited: {
                mouseArea.enabled = true;
            }

            onCurrentItemChanged: {
                root.isItemSelected = true;
                root.itemSelected(name, size, creationDate, isFolder, sizeUnits);
            }
        }
    }


    ListView {
        id: listView

        width: root.width / 1.3
        height: root.height - 2
        clip: true
        anchors {
            left: root.left
            leftMargin: 1
            top: root.top
            topMargin: 5
            bottom: root.bottom
            bottomMargin: 40
        }

        model: visualModel
    }


    MouseArea {
        id: mouseArea

        anchors.fill: parent
        acceptedButtons: Qt.AllButtons;

        onClicked: {
            if (mouse.button === Qt.RightButton) {
                contextMenu.popup()
            }
        }
    }
}
