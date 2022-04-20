import QtQuick 2.15
import QtQuick.Window 2.15
import Qt.labs.folderlistmodel 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.15

import filesystembrowser 1.0
import browsecontroller 1.0
import folderhandler 1.0
import filehandler 1.0

Window
{
    id: root

    width: 640
    height: 480
    visible: true
    title: qsTr("File Browser")

    BrowseController { id: browseController }

    FileHandler { id: fileHandler }

    FolderHandler { id: folderHandler }

    ControlPanel { id: row }

    PopupDialog{ id: createFolderFilePopup }

    WarningPopup { id: warningPopup }

    ActionConfirmationPopup { id: actionConfirmationPopup }

    ReplaceConfirmationPopup { id: replaceConfirmationPopup }

    DirectoryBrowser
    {
        id: db
        width: parent.width / 2 - 100
        height: parent.height
        anchors.top: row.bottom
    }

    DirectoryView
    {
        id: dv
        width: root.width - db.width
        height: root.height
        anchors.left: db.right
        anchors.top: row.bottom
    }



}
