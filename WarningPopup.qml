import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

CustomPopup {
    id: root

    signal closeClicked();

    property alias closeButton: closeButton
    property string msg: "message"
    property int msgFontPointSize: 13

    ColumnLayout {
        anchors.fill: parent

        Text {
            text: root.msg
            font.pointSize: root.msgFontPointSize
            Layout.alignment: Qt.AlignCenter
        }

        PopupButton {
            id: closeButton

            Layout.alignment: Qt.AlignCenter

            onClicked: root.closeClicked();
        }
    }
}
