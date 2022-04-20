import QtQuick 2.0

Rectangle
{
    id: row

    anchors.top: parent.top
    height: 25
    width: parent.width
    border.width: 1

    BackwardButton
    {
        id: backward
        height: parent.height
        width: 40
    }

    ForwardButton
    {
        id: forward
        height: parent.height
        width: 40
        anchors.left: backward.right
    }

    Text
    {
        anchors
        {
            verticalCenter: parent.verticalCenter
            left: forward.right
            leftMargin: 10
        }
        text: db.file.substring(8);
    }
}
