import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import ActionController 1.0

CustomPopup {
    id: root

    signal cancel();
    signal confirm();

    property string msg: "message"
    property bool isFolder: true
    property int inputFontPointSize: 12
    property real verticalItemSpacing: 5


    ColumnLayout {
        anchors.fill: parent
        spacing: root.verticalItemSpacing

        Item {
            //TODO add params to public interface
            width: root.width - root.horizontalPadding - 1
            height: root.height / 2

            Text {
                text: root.msg
                font.pointSize: root.inputFontPointSize
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
            }
        }

        ButtonsRow {
            Layout.fillWidth: true
            Layout.fillHeight: true

            onCancel: root.cancel();

            onConfirm: root.confirm();
        }
    }
}
