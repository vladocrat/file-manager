import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

CustomPopup {
    id: root

    signal closeClicked();

    property string msg: "message"
    property string closeBtntext: "close"
    property int fontPointSize: 13
    property string buttonHoverColor: "yellow"
    property int buttonAlignment: Qt.AlignCenter
    property int textAlignment: Qt.AlignCenter

    ColumnLayout {
        anchors.fill: parent

        Text {
            text: root.msg
            font.pointSize: root.fontPointSize
            Layout.alignment: root.textAlignment
        }

        PopupButton {
            text: root.closeBtntext
            Layout.alignment: root.buttonAlignment
            hoverColor: root.buttonHoverColor

            onClicked: root.closeClicked();
        }
    }
}
