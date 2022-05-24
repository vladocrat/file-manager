import QtQuick 2.0
import QtQuick.Controls 2.12

Button {
    id: root

    property color defaultColor: "grey"
    property color hoverColor: "black"

    palette.button: root.defaultColor
    hoverEnabled: true

    onHoveredChanged: root.palette.button = root.hovered ? root.hoverColor : root.defaultColor
}
