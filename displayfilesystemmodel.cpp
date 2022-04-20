#include "displayfilesystemmodel.h"

#include <QUrl>
DisplayFileSystemModel::DisplayFileSystemModel(QObject *parent)
    : QFileSystemModel(parent) {}

QVariant DisplayFileSystemModel::data(const QModelIndex &index, int role) const
{
    if (index.isValid() && role >= SizeRole) {
        switch (role) {
        case UrlStringRole:
            return QVariant(QUrl::fromLocalFile(filePath(index)).toString());
        default:
            break;
        }
    }
    return QFileSystemModel::data(index, role);
}

QHash<int,QByteArray> DisplayFileSystemModel::roleNames() const
{
     QHash<int, QByteArray> result = QFileSystemModel::roleNames();
     result.insert(SizeRole, QByteArrayLiteral("size"));
     result.insert(DisplayableFilePermissionsRole, QByteArrayLiteral("displayableFilePermissions"));
     result.insert(LastModifiedRole, QByteArrayLiteral("lastModified"));
     return result;
}

