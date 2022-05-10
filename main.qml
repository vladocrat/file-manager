import QtQuick 2.15
import QtQuick.Window 2.15
import Qt.labs.folderlistmodel 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.15

import filesystembrowser 1.0
import BrowseController 1.0


Window
{
    id: root

    width: 840
    height: 480
    visible: true
    title: qsTr("File Browser")

    TopBar { id: topBar }

    PopupDialog { id: createFolderFilePopup }

    WarningPopup { id: warningPopup }

    ActionConfirmationPopup { id: actionConfirmationPopup }

    ReplaceConfirmationPopup { id: replaceConfirmationPopup }

    DirectoryBrowser
    {
        id: directoryBrowser
        width: parent.width / 4
        height: parent.height
        anchors.top: topBar.bottom
    }

    DirectoryView
    {
        id: directoryView
        width: root.width / 2
        height: root.height
        anchors.left: directoryBrowser.right
        anchors.top: topBar.bottom

        onItemSelected: {
            filePreview.isFolder = isFolder
            filePreview.fileName = name
            filePreview.fileSize = size
            filePreview.creationDate = creationDate
        }
    }


    FilePreview {
        id: filePreview

        height: root.height
        width: root.width - directoryBrowser.width - directoryView.width
        anchors {
            left: directoryView.right
            top: topBar.bottom
            right: root.right
        }

    }
}
