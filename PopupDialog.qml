import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import BrowseController 1.0
import ActionController 1.0

CustomPopup {
    id: root

    signal confirm();
    signal cancel();

    property alias userInput: textInput
    property bool confirmEnabled: true
    property bool cancelEnabled: true
    property bool isFolder: true
    property string msg: {
        var type = root.isFolder ? "folder" : "file";
        return "enter a name for a " + type;
    }

    function clearAndClose() {
        root.userInput.text = "";
        root.close();
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 12

        Text {
            text: root.msg
        }

        Rectangle {
            id: inputField

            width: root.width / 1.2
            height: root.height / 4
            Layout.alignment: Qt.AlignCenter
            border.width: 1

            TextInput {
                id: textInput

                focus: root.focusInputField
                verticalAlignment: TextInput.AlignVCenter
                font.pointSize: 20
                anchors {
                    fill: parent
                    leftMargin: 5
                }
            }
        }

        ButtonsRow {
            Layout.fillWidth: true
            Layout.fillHeight: true
            confirmButton.enabled: root.confirmEnabled
            cancelButton.enabled: root.cancelEnabled

            onCancel: root.cancel();

            onConfirm: root.confirm();
        }
    }
}


