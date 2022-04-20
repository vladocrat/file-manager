import QtQuick 2.0
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.12

Popup
{
    id: root

    property string msg: ""
    property string url: ""
    property string pasteUrl: ""
    //true -> folder, false -> file
    property bool folder: true

    x: Math.round((parent.width - width) / 2)
    y: Math.round((parent.height - height) / 2)
    width: 450
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
                text: msg

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
            spacing: 90

            Rectangle
            {
                width: 1
                height: cancel.height
            }

            Button
            {
                id: cancel

                width: 70
                height: 40

                leftPadding: 10

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
                height: cancel.height

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

                    if (root.folder) {
                        if (folderHandler.replaceFolder(root.url, root.pasteUrl)) {
                            warningPopup.msg = "unable to replace " + getShortPath(root.url);
                            warningPopup.open();
                        }
                    } else {
                        if (!fileHandler.replaceFile(root.url, root.pasteUrl)) {
                            warningPopup.msg = "unable to replace " + getShortPath(root.url);
                            warningPopup.open();
                        }
                    }
                    root.close();
                }
            }

            Rectangle
            {
                width: 1
                height: cancel.height
            }

        }
    }

    function getShortPath(url) {
        var arr = url.split("/");
        return arr[arr.length - 1];
    }
}

