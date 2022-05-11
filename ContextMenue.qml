import QtQuick 2.0
import QtQuick.Controls 2.0
import ActionController 1.0
import BrowseController 1.0

Menu {
    id: root

    signal createFolderFile(var msg, var isFolder);
    signal showMessage(var msg);

    property bool pasteState: false


    y: 25
    width: 80

    MenuItem {
        text: "New folder"
        onTriggered: createFolderFile("enter folder name", true);
    }

    MenuItem {
        text: "New file"
        onTriggered: createFolderFile("enter file name", false);
    }

    MenuItem {
        text: "paste"
        enabled: pasteState

        onTriggered: {
            var pasteUrl = BrowseController.current
            console.log("pasteUrl: " + pasteUrl);
            console.log("copyUrl: " + directoryView.copyUrl);

            var index = folderModel.indexOf(copyUrl);
            if (!ActionController.copyFolderFile(copyUrl, pasteUrl)) {
               root.showMessage("failed to copy");
            }

            root.pasteState = true;
        }
    }
}
