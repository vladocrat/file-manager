import QtQuick 2.0
import QtQuick.Controls 2.0
import ActionController 1.0

Menu
{
    id: root

    y: 25
    width: 80

    MenuItem
    {
        text: "delete"

        onTriggered: {
            var url = folderModel.get(index, "fileUrl");
            setUpAndOpenActionConfirmationPopup(folderModel.isFolder(index), url, "delete ");
        }
    }


    MenuItem {
        text: "move up"

        onTriggered: {
            var url = folderModel.get(index, "fileUrl");
            console.log("was able to move folder up: " + ActionController.moveDirUp(url));
        }

    }

    MenuItem
    {
        text: "copy"

        onTriggered: {
            var url = folderModel.get(index, "fileUrl");
            console.log("copy url is: " + url);
            //TODO references bad
            contextMenu.pasteState = true;
            directoryView.copyUrl = url;
            directoryView.isFolder = folderModel.isFolder(index);
        }
    }

      //TODO change to signals?
    function setUpAndOpenActionConfirmationPopup(isFolder, url, msg) {
        actionConfirmationPopup.folder = isFolder
        actionConfirmationPopup.url = url;
        actionConfirmationPopup.msg = msg;
        actionConfirmationPopup.open();
    }

}
