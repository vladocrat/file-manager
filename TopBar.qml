import QtQuick 2.0
import QtQuick.Controls 2.12
import BrowseController 1.0

Rectangle
{
    id: root

    property string currentDir : BrowseController.current
    anchors.top: parent.top
    height: 25
    width: parent.width
    border.width: 1

    NavigationButton {
        id: backWardButton

        enabled: BrowseController.backwardAvaliable
        height: parent.height
        width: 40
        text: "<<"

        onClicked: {
            BrowseController.moveBackward();
        }
    }

    NavigationButton {
        id: forwardButton

        enabled: BrowseController.forwardAvaliable
        height: parent.height
        width: 40
        anchors.left: backWardButton.right
        text: ">>"

        onClicked:  {
            BrowseController.moveForward();
        }
    }

    Text
    {
        anchors
        {
            verticalCenter: parent.verticalCenter
            left: forwardButton.right
            leftMargin: 10
        }
        //removes "file:///" part of the link
        text: root.currentDir.substring(8)
     }
}

