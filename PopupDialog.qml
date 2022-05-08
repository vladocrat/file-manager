import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import FolderHandler 1.0
import BrowseController 1.0
import ActionController 1.0

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
                id: textInput

                focus: true
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
                    textInput.text = "";
                    root.close();
                }
            }

            Button
            {
                id: accept

                width: 70
                height: 35

                hoverEnabled: true
                enabled: textInput.text.length > 0

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
                    root.folderName = textInput.text;
                    var fullFilePath = BrowseController.current + "/" + textInput.text;
                    console.log("full path to folder/file: " + fullFilePath);


                    if (ActionController.createDir(fullFilePath, root.folder)) {
                        //TODO something with popups?
                    }

                    textInput.text = "";
                    root.close();
                }

                //TODO remove?
                function setMessageAndOpenWarningPopup(msg) {
                    warningPopup.msg = msg;
                    warningPopup.open();
                }
            }
        }
    }
}
