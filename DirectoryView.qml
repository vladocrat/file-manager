import QtQuick 2.15
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.15
import Qt.labs.folderlistmodel 2.0
import filesystembrowser 1.0
import QtQml.Models 2.2
import BrowseController 1.0

Rectangle
{
    id: root

    signal itemSelected(var name, var size, var creationDate, var isFolder);

    property string copyUrl: ""
    property bool isFolder: false

    color: "white"
    border.width: 1

    ContextMenue { id: contextMenu }

    DelegateModel
    {
        id: visualModel

        model: FolderListModel
        {
            id: folderModel

            folder: BrowseController.current
            showDirsFirst: true
        }

        delegate: DirectoryViewDelegate
        {
            id: delegate

            width: root.width
            height: 40

            onCurrentIndexChanged: {
                listView.currentIndex = index
            }

            onMouseEntered: {
                mouseArea.enabled = false;
            }

            onMouseExited: {
                mouseArea.enabled = true;
            }

            onCurrentItemChanged: {
                itemSelected(name, size, creationDate, isFolder);
            }
        }
    }

    ListView
    {
        id: listView

        clip: true
        width: root.width - 2
        height: root.height - 2
        anchors {
            left: root.left
            right: root.right
            leftMargin: 1
            rightMargin: 1
        }

        model: visualModel
    }

    MouseArea
    {
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
