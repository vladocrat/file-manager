import QtQuick 2.0
import QtQuick.Controls 2.0
import ActionController 1.0

Menu {
    id: root

    signal copy(var url);
    signal showMessage(var msg);

    y: 25
    width: 80

    MenuItem {
        text: "delete"

        onTriggered: {
            var url = folderModel.get(index, "fileUrl");
            if (!ActionController.deleteFolderFile(url)) {
                showMessage("failed to delete: " + url);
            }
        }
    }


    MenuItem {
        text: "move up"

        onTriggered: {
            var url = folderModel.get(index, "fileUrl");
            if (!ActionController.moveDirUp(url)) {
                showMessage("failed to move dir up");
            }
        }
    }

    MenuItem {
        text: "copy"

        onTriggered: {
            var url = folderModel.get(index, "fileUrl");
            console.log("copy url is: " + url);

            root.copy(url);
        }
    }
}
