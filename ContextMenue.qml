import QtQuick 2.0
import QtQuick.Controls 2.0
import ActionController 1.0
import BrowseController 1.0

Menu {
    id: root

    property bool pasteState: false

    background: Rectangle {
        implicitWidth: 170
        border.width: 1
        border.color: "black"
    }

    delegate: ContextMenuItem { }
}
