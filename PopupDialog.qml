import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Popup
{
    id: root

    property string folderName: ""
    property string fileName: ""
    property string msg: ""

    //true -> folder, false -> file
    property bool folder: true

    x: Math.round((parent.width - width) / 2)
    y: Math.round((parent.height - height) / 2)
    width: 300
    height: 150
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape

    ColumnLayout {

        anchors.fill: parent
        spacing: 5

        Text {
            text: root.msg
        }

        Rectangle
        {
            id: inputField

            width: root.width - height
            height: root.height / 4
            border.width: 1

            TextInput
            {
                id: ti

                anchors.fill: parent
                anchors.leftMargin: 5
                verticalAlignment: TextInput.AlignVCenter
                font.pointSize: 11
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
                    ti.text = "";
                    root.close();
                }
            }

            Button
            {
                id: accept

                width: 70
                height: 35

                hoverEnabled: true
                enabled: ti.text.length > 0

                //palette.button: hovered ? "red" : "white"

                Text
                {
                    text: "accept"
                    anchors
                    {
                        verticalCenter: parent.verticalCenter
                        horizontalCenter: parent.horizontalCenter
                    }
                }

                onClicked: {
                    root.folderName = ti.text;
                    var fullFilePath = db.file + "/" + ti.text;
                    print("full path to folder/file: " + fullFilePath);

                    ti.text = "";

                    if (root.folder) {
                        //if folder
                        if (folderHandler.folderExists(fullFilePath)) {
                            setMessageAndOpenWarningPopup("folder \"" + root.folderName + "\" already exists");
                            return;
                        }

                        if (!folderHandler.createFolder(db.file + "/" + root.folderName)) {
                            setMessageAndOpenWarningPopup("unable to create folder");
                        }

                    } else {
                        //if file
                        if (fileHandler.fileExists(fullFilePath)) {
                            setMessageAndOpenWarningPopup("file \"" + root.folderName + "\" already exists");
                            return;
                        }

                        if (!fileHandler.createFile(db.file + "/" + root.folderName)) {
                            setMessageAndOpenWarningPopup("unable to create file");
                        }
                    }
                    root.close();
                }

                function setMessageAndOpenWarningPopup(msg) {
                    warningPopup.msg = msg;
                    warningPopup.open();
                }
            }
        }
    }
}
