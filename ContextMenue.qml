import QtQuick 2.0
import QtQuick.Controls 2.0


Menu
{
    id: root

    property bool pasteState: false

    y: 25
    width: 80

    MenuItem
    {
        text: "New folder"
        onTriggered: setAndOpenFolderFilePopup(true, "enter folder name");
    }

    MenuItem
    {
        text: "New file"
        onTriggered: setAndOpenFolderFilePopup(false, "enter file name");

    }

    MenuItem
    {
        text: "paste"

        enabled: pasteState

        onTriggered: {
            var pasteUrl = db.file
            print("pasteUrl: " + pasteUrl);
            print("copyUrl: " + dv.copyUrl);

            var msg = "";
            if (dv.copyUrl === pasteUrl) {
                print("copy url == paste url");
                if (dv.isFolder) {
                    msg = "replace existing folder " + replaceConfirmationPopup.getShortPath(dv.copyUrl) + "?";
                    setAndOpenReplaceConfirmationPopup(true,
                                                       msg,
                                                       copyUrl,
                                                       pasteUrl);
                } else {
                    msg = "replace existing file " + replaceConfirmationPopup.getShortPath(copyUrl) + "?";
                    setAndOpenReplaceConfirmationPopup(false,
                                                       msg,
                                                       copyUrl,
                                                       pasteUrl);
                }
                root.pasteState = true;
                return;
            }

            if (dv.isFolder) {
                if (!folderHandler.copyFolder(copyUrl, pasteUrl + "/" + replaceConfirmationPopup.getShortPath(copyUrl))) {
                    msg = "replace existing folder " + replaceConfirmationPopup.getShortPath(dv.copyUrl) + "?";
                    setAndOpenReplaceConfirmationPopup(true,
                                                       msg,
                                                       copyUrl,
                                                       pasteUrl);
                }

            } else {
                msg = "replace existing file " + replaceConfirmationPopup.getShortPath(copyUrl) + "?";
                if (!fileHandler.copyFile(copyUrl, pasteUrl)) {
                    setAndOpenReplaceConfirmationPopup(false,
                                                       msg,
                                                       copyUrl,
                                                       pasteUrl);
                }
            }
             root.pasteState = true;
        }
    }

    function setAndOpenReplaceConfirmationPopup(isFolder, msg, copyUrl, pasteUrl) {
        replaceConfirmationPopup.folder = isFolder;
        replaceConfirmationPopup.msg = msg;
        replaceConfirmationPopup.url = copyUrl;
        replaceConfirmationPopup.pasteUrl = pasteUrl;
        replaceConfirmationPopup.open();
    }

    function setAndOpenFolderFilePopup(isFolder, msg) {
        createFolderFilePopup.folder = isFolder;
        createFolderFilePopup.msg = msg;
        createFolderFilePopup.open();
    }
}
