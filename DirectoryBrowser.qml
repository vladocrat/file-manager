import QtQuick 2.0
import QtQuick.Controls 1.4
import filesystembrowser 1.0

TreeView
{
    id: root

    property string file: "file:///c:/"

    model: fileSystemModel
    rootIndex: rootPathIndex

    TableViewColumn
    {
        title: "Name"
        role: "fileName"
        resizable: true
    }

    onActivated: {
        var url = fileSystemModel.data(index, FileSystemModel.UrlStringRole);
        browseController.addForward(root.file);
        root.file = url;
    }
}
