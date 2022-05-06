import QtQuick 2.0
import QtQuick.Controls 2.12

Button {
    id: root

    hoverEnabled: true

    background: Rectangle {
        id: background

        color: root.palette.button
        border.width: root.activeFocus ? 2 : 1
        border.color: "#888"
    }

    onHoveredChanged: {
        background.color = hovered ? "black" : "grey"
    }
}
