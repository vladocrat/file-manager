import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

RowLayout
{
    id: root

    signal cancel();
    signal confirm();

    property bool confirmEnabled: true
    property bool cancelEnabled: true
    property real firstItemWidth: 100
    property bool firstItemFillWidth: true
    property real firstItemHeight: 35
    property real cancelButtonWidth: 70
    property real cancelButtonHeight: 35
    property string cancelButtonHoverColor: "red"
    property string cancelButtonText: "cancel"
    property real secondItemWidth: 20
    property real secondItemHeight: 35
    property real confirmButtonWidth: 70
    property real confirmButtonHeight: 35
    property string confrimButtonHoverColor: "green"
    property string confirmButtonText: "confrim"

    Item
    {
        Layout.preferredWidth: root.firstItemWidth
        Layout.preferredHeight: root.firstItemHeight
        Layout.fillWidth: root.firstItemFillWidth
    }

    PopupButton
    {
        Layout.preferredWidth: root.cancelButtonWidth
        Layout.preferredHeight: root.cancelButtonHeight
        hoverColor: root.cancelButtonHoverColor
        text: root.cancelButtonText
        enabled: root.cancelEnabled

        onClicked: root.cancel();
    }

    Item
    {
        Layout.preferredWidth: root.secondItemWidth
        Layout.preferredHeight: root.secondItemHeight
    }

    PopupButton
    {
        Layout.preferredWidth: root.confirmButtonWidth
        Layout.preferredHeight: root.confirmButtonHeight
        hoverColor: root.confrimButtonHoverColor
        text: root.confirmButtonText
        enabled: root.confirmEnabled

        //TODO rendered as if not enabled even though it works?
        onClicked: root.confirm();
    }
}
