import QtQuick 2.0
import QtQuick.Controls 2.12

Popup {
    id: root

    x: Math.round((parent.width - width) / 2)
    y: Math.round((parent.height - height) / 2)
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape
}
