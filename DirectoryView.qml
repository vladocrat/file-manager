import QtQuick 2.15
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.15
import Qt.labs.folderlistmodel 2.0
import filesystembrowser 1.0
import QtQml.Models 2.2

Rectangle
{
    id: root

    property string copyUrl: ""
    property bool isFolder: false

    color: "white"
    z: -1

    ContextMenue { id: contextMenu }

    DelegateModel {
        id: visualModel
        model: FolderListModel
        {
            id: folderModel
            folder: db.file
            showDirsFirst: true
        }

        delegate: DirectoryViewDelegate
        {
            width: root.width
            height: 22
        }
    }


    ListView
    {
        id: lw
        z: 1
        anchors.fill: parent
        model: visualModel
    }

    MouseArea
    {
        anchors.fill: parent
        acceptedButtons: Qt.AllButtons;

        onClicked: {
            if (mouse.button === Qt.RightButton) {
                contextMenu.popup()
            }
        }
    }
}
