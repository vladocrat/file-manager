import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

RowLayout {
    id: root

    signal cancel();
    signal confirm();

    property alias confirmButton: confirm
    property alias cancelButton: cancel
    property real commonHeight: 35

    Item {
        Layout.preferredWidth: 100
        Layout.preferredHeight: root.commonHeight
    }

    PopupButton {
        id: cancel

        Layout.preferredWidth: 70
        Layout.preferredHeight: root.commonHeight
        text: "cancel"
        hoverColor: "red"

        onClicked: root.cancel();
    }

    Item {
        Layout.preferredWidth:  20
        Layout.preferredHeight: root.commonHeight
    }

    PopupButton {
        id: confirm

        Layout.preferredWidth: 70
        Layout.preferredHeight: root.commonHeight
        text: "confirm"
        hoverColor: "green"

        //TODO rendered as if not enabled even though it works?
        onClicked: root.confirm();
    }
}
