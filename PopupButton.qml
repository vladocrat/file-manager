import QtQuick 2.0
import QtQuick.Controls 2.12

Button {
    id: root

    property string defaultColor: "grey"
    property string hoverColor: "black"

    palette.button: root.defaultColor
    hoverEnabled: true

    onHoveredChanged: root.palette.button = root.hovered ? root.hoverColor : root.defaultColor
}
