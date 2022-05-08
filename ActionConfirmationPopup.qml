import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import FolderHandler 1.0
import ActionController 1.0

Popup
{
    id: root

    property string msg: ""
    property string url: ""
    //true -> folder, false -> file
    property bool folder: true

    x: Math.round((parent.width - width) / 2)
    y: Math.round((parent.height - height) / 2)
    width: 300
    height: 150
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape

    ColumnLayout
    {
        anchors.fill: parent
        spacing: 5

        Rectangle
        {
            width: root.width - root.horizontalPadding - 1
            height: root.height / 2

            Text
            {
                text: {
                    var path = getShortPath(root.url)
                    if (folder) {
                        return msg + " folder \"" + path + "\"?";
                    }
                    return  msg + "file \"" + path + "\"?";
                }

                font.pointSize: 12
                anchors
                {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
            }

        }

        Row
        {
            spacing: 40

            Rectangle
            {
                width: 2
                height: 35
            }

            Button
            {
                id: cancel

                width: 70
                height: 35

                Text
                {
                    text: "cancel"
                    anchors
                    {
                        verticalCenter: parent.verticalCenter
                        horizontalCenter: parent.horizontalCenter
                    }
                }

                onClicked: {
                    root.close();
                }
            }

            Button
            {
                id: comfirm

                width: 70
                height: 35

                Text
                {
                    text: "confirm"
                    anchors
                    {
                        verticalCenter: parent.verticalCenter
                        horizontalCenter: parent.horizontalCenter
                    }
                }

                onClicked: {
                    var path = getShortPath(url);
                    var msg = "unable to delete"

                    if (!ActionController.deleteFolder(url)) {

                    }
                    root.close();

                    /*
                    if (folder) {
                       if (!FolderHandler.deleteFolder(url)) {
                           warningPopup.msg = msg + " folder " + path;
                           warningPopup.open();
                       }
                    } else {
                        if (FolderHandler.deleteFile(url)) {
                            warningPopup.msg = msg + " file " + path;
                        }
                    }
                    */

                }
            }
        }
    }

    function getShortPath(url) {
        var arr = url.split("/");
        return arr[arr.length - 1];
    }
}
