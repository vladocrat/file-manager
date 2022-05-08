import QtQuick 2.0
import QtQuick.Controls 2.12

Popup
{
    id: root

    property string msg: ""

    x: Math.round((parent.width - width) / 2)
    y: Math.round((parent.height - height) / 2)
    width: 300
    height: 125
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape

    //TODO remove rectangle and use what popup provides
    Rectangle
    {
        id: container

        anchors.fill: parent

        Text
        {
            id: message

            text: msg
            font.pointSize: 13
            anchors.horizontalCenter: parent.horizontalCenter
           // anchors.leftMargin: root.horizontalPadding / 2
        }

        Button
        {
            anchors
            {
                top: message.bottom
                left: container.left
                topMargin: 20
                //leftMargin: root.width / 4
                horizontalCenter: parent.horizontalCenter
            }

            Text
            {
                text: "close"
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
    }
}
