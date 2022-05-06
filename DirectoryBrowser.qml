import QtQuick 2.0
import QtQuick.Controls 1.4
import filesystembrowser 1.0

import BrowseController 1.0
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
        BrowseController.addForward(url);
        //console.log(root.file + " " + url)
        root.file = url;
    }
}
