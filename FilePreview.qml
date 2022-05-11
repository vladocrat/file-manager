import QtQuick 2.0
import QtQuick.Layouts 1.12

ColumnLayout {
    id: root

    //TODO if file name is too large it goes out of bounds
    //TODO folder size isn't calculated
    //TODO untis for size aren't shown
    property string fileName
    property int fileSize: 0
    property string creationDate: ""
    property bool isFolder: true

    Text {
        text: root.fileName
        font.pointSize: 12

        Layout.alignment: Qt.AlignCenter
    }

    Image {
        source: root.isFolder ?  "/images/folder.png" : "/images/file.png"

        Layout.preferredHeight: 60
        Layout.preferredWidth:  60
        Layout.alignment: Qt.AlignCenter
    }

    Text {
        text: "fileSize: " + root.fileSize

        Layout.alignment: Qt.AlignCenter
    }

    Text {
        text: "creation date: " + root.creationDate

        Layout.alignment: Qt.AlignCenter
    }

    Item {
        Layout.fillHeight: true
    }
}

