import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt.labs.folderlistmodel 2.0
import filesystembrowser 1.0
import QtQml.Models 2.2
import BrowseController 1.0

Rectangle {
    id: root

    signal itemSelected(var name, var size, var creationDate, var isFolder);
    signal createFolderFile(var msg, var isFolder);
    signal showMessage(var msg);

    property string copyUrl: ""

    color: "white"
    border.width: 1

    ContextMenue {
        id: contextMenu

        onCreateFolderFile: {
            root.createFolderFile(msg, isFolder);
        }

        onShowMessage: {
            root.showMessage(msg);
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

            onShowMessage: {
                root.showMessage(msg);
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
                root.itemSelected(name, size, creationDate, isFolder);
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
