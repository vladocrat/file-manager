import QtQuick 2.0

Rectangle
{
    id: root

    border
    {
        width: 1
    }

    color: if (mouseArea.pressed) {
               return "#999494"
           } else if (mouseArea.containsMouse) {
               return "grey"
           } else {
               return "white"
           }

    Text
    {
        text: ">>"
        anchors
        {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
    }

    MouseArea
    {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            db.file = browseController.moveForward(db.file);
        }
    }
}
