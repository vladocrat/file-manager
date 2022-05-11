import QtQuick 2.15
import QtQuick.Window 2.15
import Qt.labs.folderlistmodel 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.15

import filesystembrowser 1.0
import BrowseController 1.0


Window {
    id: root

    width: 900
    height: 600
    visible: true
    title: qsTr("File Browser")

    TopBar {
        id: topBar

        anchors.top: parent.top
        height: 35
        width: parent.width
    }

    PopupDialog {
        id: createFolderFilePopup

        width: 300
        height: 120
        confirmEnabled: createFolderFilePopup.userInput.text.length > 0
        userInput {
            font.pointSize: 11
            focus: true
        }

        onCancel: {
            createFolderFilePopup.clearAndClose();
        }

        onConfirm: {
            //TODO shouldn't be passed like this
            var fullFilePath = BrowseController.current + "/" + createFolderFilePopup.userInput;
            console.log("full path to isFolder/file: " + fullFilePath);

            if (!ActionController.createFolderFile(fullFilePath, createFolderFilePopup.isFolder)) {
                var type = createFolderFilePopup.isFolder ? "folder" : "file";
                warningPopup.msg = "failed to create " + type;
                warningPopup.open();
            }

            createFolderFilePopup.clearAndClose();
        }
    }

    WarningPopup {
        id: warningPopup

        width: 300
        height: 125

        onCloseClicked: {
            warningPopup.close();
        }
    }

    ActionConfirmationPopup {
        id: actionConfirmationPopup

        width: 300
        height: 150

        onCancel: {

        }

        onConfirm: {

        }

    }

    DirectoryBrowser {
        id: directoryBrowser

        width: root.width / 4
        height: root.height
        anchors {
            top: topBar.bottom
            bottom: root.bottom
            bottomMargin: 50
        }
    }

    DirectoryView {
        id: directoryView

        width: root.width / 2
        height: root.height
        anchors {
            left: directoryBrowser.right
            top: topBar.bottom
        }

        onShowPopupMessage: {
            warningPopup.msg = msg;
            warningPopup.open();
        }

        onCreateFolderFile: {
            createFolderFilePopup.isFolder = isFolder
            createFolderFilePopup.msg = msg
            createFolderFilePopup.open();
        }

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
