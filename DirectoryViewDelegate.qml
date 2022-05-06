import QtQuick 2.15
import QtQuick.Controls 2.0
import BrowseController 1.0

Rectangle
{
    id: root

    color: {
        if(mouseArea.pressed) {
            return "#999494"
        } else if (mouseArea.containsMouse) {
            return "grey"
        }
        return "white"
    }

    Rectangle
    {
        id: image
        z: parent.z + 1
        width: 10
        height: 10
        color: folderModel.isFolder(index) ? "green" : "yellow"

        anchors
        {
            verticalCenter: parent.verticalCenter
            left: root.left
            leftMargin: 7
        }
    }


    Text
    {
        id: text

        leftPadding: 25
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

        z: parent.z + 1


        drag.onActiveChanged: {
            if (mouseArea.drag.active) {
                dragRect.dragItemIndex = index;
            }
        }


        onDoubleClicked: {
            //if a folder -> open a folder -> change view to that folder
            //if a file -> open externaly
            var url = folderModel.get(index, "fileUrl");

            if (folderModel.isFolder(index)) {
                BrowseController.addForward(url);
                db.file = url;
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

            if (!folderModel.isFolder(to)) {
                return;
            }

            if (folderModel.isFolder(from)) {
                print("from (folder): " + from + " to: " + to);
                if (!folderHandler.moveFolder(from, to)) {
                    setUpMessageBox("unable to move folder");
                }
            } else {
                print("from (file): " + from + " to: " + to);
                if (!fileHandler.moveFile(from, to)) {
                    setUpMessageBox("unable to move file");
                    }
            }
        }

        function setUpMessageBox(msg) {
            warningPopup.msg = msg;
            warningPopup.open();

        }

        states: [
            State {
                when: dragTarget.containsDrag
                PropertyChanges {
                    target: root
                    color: "red"
                }
            }
        ]
    }
}
