import QtQuick 2.15
import QtQuick.Controls 2.0

import BrowseController 1.0
import ActionController 1.0
import FileInfo 1.0

Rectangle {
    id: root

    signal currentItemChanged(var name, var size, var creationDate, var isFolder, var sizeUnits);
    signal mouseEntered();
    signal mouseExited();
    signal currentIndexChanged(var index);
    signal copyUrlChanged(var url);
    signal showPopupMessage(var msg);

    property color pressedColor: "#999494"
    property color hoverColor: "grey"
    property color selectedColor: "#5f67fa"
    property color notSeleceted: "white"

    color: {
        if (mouseArea.pressed) {
            return pressedColor;
        } else if (mouseArea.containsMouse) {
            return ListView.isCurrentItem ? selectedColor : hoverColor;
        } else if (ListView.isCurrentItem) {
            return selectedColor;
        }
        return notSeleceted;
    }

    Image {
        id: image

        width: 20
        height: 20
        source: folderModel.isFolder(index) ? "/images/folder.png" : "/images/file.png"

        anchors {
            verticalCenter: parent.verticalCenter
            left: root.left
            leftMargin: 10
        }
    }

    Text {
        leftPadding: 10
        text: fileName
        anchors {
            verticalCenter: parent.verticalCenter
            left: image.right
        }
    }

    ContextMenue {
        id: elemActionMenu

        ContextMenuItem {
            text: "delete"

            onTriggered: {
                var url = folderModel.get(index, "fileUrl");
                if (!ActionController.deleteFolderFile(url)) {
                    root.showPopupMessage("failed to delete: " + url);
                }
            }
        }

        ContextMenuItem {
            text: "move up"

            onTriggered: {
                var url = folderModel.get(index, "fileUrl");
                if (!ActionController.moveDirUp(url)) {
                    root.showPopupMessage("failed to move dir up");
                }
            }
        }

        ContextMenuItem {
            text: "copy"

            onTriggered: {
                var url = folderModel.get(index, "fileUrl");
                console.log("copy url is: " + url);

                root.copyUrlChanged(url);
            }
        }
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        drag.target: dragRect
        hoverEnabled: true
        acceptedButtons: Qt.AllButtons

        onEntered: {
            root.mouseEntered();
        }

        onExited: {
            root.mouseExited();
        }

        drag.onActiveChanged: {
            if (mouseArea.drag.active) {
                dragRect.dragItemIndex = index;
            }
        }

        onClicked: {
            if (mouse.button === Qt.RightButton) {
                elemActionMenu.popup();
                root.currentIndexChanged(index);
                return;
            }

            root.currentIndexChanged(index);
            var url = folderModel.get(index, "fileUrl");
            console.log(url);
            var name = FileInfo.name(url);
            var size = FileInfo.size(url);
            var date = FileInfo.creationDate(url);
            var isFolder = FileInfo.isFolder(url);
            var sizeUnits = FileInfo.sizeUnits();
            root.currentItemChanged(name, size, date, isFolder, sizeUnits);
        }

        onDoubleClicked: {
            //if a folder -> open a folder -> change view to that folder
            //if a file -> open externaly
            var url = folderModel.get(index, "fileUrl");

            if (folderModel.isFolder(index)) {
                BrowseController.addForward(url);
                root.mouseExited();
            } else {
                Qt.openUrlExternally(url);
            }
        }
    }

    Rectangle {
        id: dragRect

        property int dragItemIndex: index

        states: [
            State {
                when: dragRect.Drag.active

                AnchorChanges {
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

    DropArea {
        id: dragTarget

        property var dragItemIndex
        property bool canDrop: false

        width: root.width
        height: root.height

        onEntered: {
            dragItemIndex = drag.source.dragItemIndex
        }

        onDropped: {
            var from = folderModel.get(drag.source.dragItemIndex, "fileUrl");
            var to = folderModel.get(dragRect.dragItemIndex, "fileUrl");
            console.log("from: " + from);
            console.log("to: " + to);

            if (!dragTarget.canDrop) {
                console.log("can't drop here");
                return;
            }


            if (!ActionController.moveFolder(from, to)) {
                root.showPopupMessage("failed to move " + folderModel.isFolder(dragItemIndex));
            }
        }

        states: [
            State {
                when: dragTarget.containsDrag
                PropertyChanges {
                    target: root
                    color: {
                        if (dragTarget.dragItemIndex === dragRect.dragItemIndex) {
                            return "red";
                        }

                        return folderModel.isFolder(dragRect.dragItemIndex) ? "green" : "red";
                    }
                }

                PropertyChanges {
                    target: dragTarget
                    canDrop: {
                        if (dragTarget.dragItemIndex === dragRect.dragItemIndex) {
                            return false;
                        }

                        return folderModel.isFolder(dragRect.dragItemIndex);
                    }
                }
            }
        ]
    }
}
