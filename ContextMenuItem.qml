import QtQuick 2.0
import QtQuick.Controls 2.12

MenuItem {
    id: root

    implicitHeight: 50
    background: Rectangle {
        //implicitWidth: 170
        color: root.highlighted ? "lightblue" : "transparent"
//        anchors {
//            left: parent.left
//            leftMargin: 3
//            right: parent.right
//            rightMargin: 3
//        }
    }
}
