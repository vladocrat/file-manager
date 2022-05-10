#include "fileinfo.h"

#include <QFileInfo>
#include <QUrl>
#include <QDateTime>
#include <QDirIterator>
#include "folderhandler.h"

FileInfo::FileInfo(QObject *parent)
    : QObject{parent}
{

}

QString FileInfo::name(const QUrl &path) const
{
    return path.fileName();
}

int FileInfo::size(const QUrl &path) const
{
    //TODO convert size to mb
    FolderHandler handler;
    if (handler.isFolder(path)) {
        //??????? to slow?
//        QDirIterator it(path.toLocalFile(), QDirIterator::Subdirectories);
//           long total = 0;
//           while (it.hasNext()) {
//               total += it.fileInfo().size();
//           }
//           return total;
    }

    return QFileInfo(path.toLocalFile()).size();
}

QDateTime FileInfo::creationDate(const QUrl &path) const
{
    return QFileInfo(path.toLocalFile()).birthTime();
}

bool FileInfo::isFolder(const QUrl &path) const
{
    return FolderHandler().isFolder(path);
}
