import QtQuick 2.0
import QtQuick.Controls 2.0

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
           if (folderModel.isFolder(index)) {
               folderHandler.moveUp(url);
           } else {
               fileHandler.moveUp(url);
           }
        }
    }

    MenuItem
    {
       text: "copy"

       onTriggered: {
           var url = folderModel.get(index, "fileUrl");
           print("copy url is: " + url);
           contextMenu.pasteState = true;
           dv.copyUrl = url;
           dv.isFolder = folderModel.isFolder(index);
       }
    }


    function setUpAndOpenActionConfirmationPopup(isFolder, url, msg) {
        actionConfirmationPopup.folder = isFolder
        actionConfirmationPopup.url = url;
        actionConfirmationPopup.msg = msg;
        actionConfirmationPopup.open();
    }

}
