import QtQuick 2.0
import QtQuick.Controls 2.0
import FolderHandler 1.0
import ActionController 1.0
import BrowseController 1.0

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
            var pasteUrl = BrowseController.current
            console.log("pasteUrl: " + pasteUrl);
            console.log("copyUrl: " + dv.copyUrl);

            var msg = "";
            if (dv.copyUrl === pasteUrl) {
                console.log("copy url == paste url");
                //should just make a copy of a folder/file and add "-- copy at the end of the name"
                 if (ActionController.makecopy(copyUrl)) {
                    //TODO
                }

                /*

                //                if (dv.isFolder) {
                //                    msg = "replace existing folder " + replaceConfirmationPopup.getShortPath(dv.copyUrl) + "?";
                //                    setAndOpenReplaceConfirmationPopup(true,
                //                                                       msg,
                //                                                       copyUrl,
                //                                                       pasteUrl);
                //                } else {
                //                    msg = "replace existing file " + replaceConfirmationPopup.getShortPath(copyUrl) + "?";
                //                    setAndOpenReplaceConfirmationPopup(false,
                //                                                       msg,
                //                                                       copyUrl,
                //                                                       pasteUrl);
                //                }
                //                root.pasteState = true;
                //                return;
                */
            }

            /*
            //            if (dv.isFolder) {
            //                if (!FolderHandler.copyFolder(copyUrl, pasteUrl + "/" + replaceConfirmationPopup.getShortPath(copyUrl))) {
            //                    msg = "replace existing folder " + replaceConfirmationPopup.getShortPath(dv.copyUrl) + "?";
            //                    setAndOpenReplaceConfirmationPopup(true,
            //                                                       msg,
            //                                                       copyUrl,
            //                                                       pasteUrl);
            //                }

            //            } else {
            //                msg = "replace existing file " + replaceConfirmationPopup.getShortPath(copyUrl) + "?";
            //                if (!fileHandler.copyFile(copyUrl, pasteUrl)) {
            //                    setAndOpenReplaceConfirmationPopup(false,
            //                                                       msg,
            //                                                       copyUrl,
            //                                                       pasteUrl);
            //                }
            //            }
            */
            var index = folderModel.indexOf(copyUrl);
            if (ActionController.copyFolder(copyUrl, BrowseController.current)) {
                //TODO
            }
            root.pasteState = true;
        }
    }

    function setAndOpenReplaceConfirmationPopup(isFolder, msg, copyUrl, pasteUrl) {
        replaceConfirmationPopup.isFolder = isFolder;
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
