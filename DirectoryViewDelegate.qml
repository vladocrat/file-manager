import QtQuick 2.15
import QtQuick.Controls 2.0

import BrowseController 1.0
import ActionController 1.0
import FileInfo 1.0

Rectangle
{
    id: root

    signal currentItemChanged(var name, var size, var creationDate, var isFolder);

    property string pressedColor: "#999494"
    property string hoverColor: "grey"
    property string selectedColor: "#5f67fa"
    property string notSeleceted: "white"

    color: {
        if(mouseArea.pressed) {
            return pressedColor;
        } else if (mouseArea.containsMouse) {
            return ListView.isCurrentItem ? selectedColor : hoverColor;
        } else if (ListView.isCurrentItem) {
            return selectedColor;
        }
        return notSeleceted;
    }

    Image
    {
        id: image
        width: 20
        height: 20
        source: folderModel.isFolder(index) ? "/images/folder.png" : "/images/file.png"

        anchors
        {
            verticalCenter: parent.verticalCenter
            left: root.left
            leftMargin: 10
        }
    }


    Text
    {
        id: text

        leftPadding: 10
        anchors.left: image.right
        anchors.verticalCenter: parent.verticalCenter
        text: fileName
    }

    ElemActionMenue { id: elemActionMenu }

    Button
    {
        id: utilityMenu
        z: parent.z + 3
        text: "..."
        height: parent.height
        width: 40
        anchors.right: root.right

        onClicked: {
            elemActionMenu.popup();
        }
    }

    MouseArea
    {
        id: mouseArea

        anchors.fill: parent
        drag.target: dragRect
        hoverEnabled: true

        //TODO delete all z interactions
        z: parent.z + 1


        drag.onActiveChanged: {
            if (mouseArea.drag.active) {
                dragRect.dragItemIndex = index;
            }
        }

        onClicked: {
            lw.currentIndex = index;
            var url = folderModel.get(index, "fileUrl");
            console.log(url);
            var name = FileInfo.name(url);
            var size = FileInfo.size(url);
            var date = FileInfo.creationDate(url);
            var isFolder = FileInfo.isFolder(url);
            currentItemChanged(name, size, date, isFolder);
        }

        onDoubleClicked: {
            //if a folder -> open a folder -> change view to that folder
            //if a file -> open externaly
            var url = folderModel.get(index, "fileUrl");

            if (folderModel.isFolder(index)) {
                BrowseController.addForward(url);
                directoryBrowser.file = url;
            } else {
                Qt.openUrlExternally(url);
            }
        }
    }

    Rectangle
    {
        id: dragRect

        property int dragItemIndex: index

        states: [
            State {
                when: dragRect.Drag.active
                ParentChange
                {
                    target: dragRect
                    parent: lw
                }

                AnchorChanges
                {
                    target: dragRect
                    anchors.horizontalCenter: undefined
                    anchors.verticalCenter: undefined
                }
            }
        ]

        Drag.dragType: Drag.Automatic
        Drag.active: mouseArea.drag.active
        Drag.hotSpot.x: dragRect.width / 2
        Drag.hotSpot.y: dragRect.height / 2
    }


    DropArea
    {
        id: dragTarget

        width: root.width
        height: root.height

        onDropped: {
            console.log("dragged", drag.source.dragItemIndex);
            console.log("moved", dragRect.dragItemIndex);
            var from = folderModel.get(drag.source.dragItemIndex, "fileUrl");
            var to = folderModel.get(dragRect.dragItemIndex, "fileUrl");
            console.log("from: " + from);
            console.log("to: " + to);
            //TODO add popup
            console.log("folder moved: " + ActionController.moveFolder(from, to));
        }

        //TODO needed at all? look at Win10 impl
        function setUpMessageBox(msg) {
            warningPopup.msg = msg;
            warningPopup.open();
        }

        states: [
            State {
                //TODO enable drag area only when able to drop...
                when: dragTarget.containsDrag
                PropertyChanges {
                    target: root
                    color: !folderModel.isFolder(dragRect.dragItemIndex) ? "red" : "green"
                }
            }
        ]
    }
}
