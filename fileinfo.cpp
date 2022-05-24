#include "fileinfo.h"

#include <QFileInfo>
#include <QUrl>
#include <QDateTime>
#include <QDebug>
#include <QDirIterator>
#include <utility>
#include "folderhandler.h"

FileInfo::FileInfo(QObject *parent)
    : QObject { parent }
{

}

QString FileInfo::name(const QUrl &path) const
{
    return path.fileName();
}

int FileInfo::size(const QUrl &path)
{
    if (FolderHandler::isFolder(path)) {
        long long total = 0;
        qDebug() << path.toLocalFile();
        QDirIterator it(path.toLocalFile(), QDirIterator::Subdirectories);
        //TODO if size of the folder is too big (exceeds long long) everything breaks
//        while (it.hasNext()) {
//            total += it.fileInfo().size();
//            qDebug() << it.next();
//        }

         auto info = convertedSize(total);

        return total;
    }

    int fileSize = QFileInfo(path.toLocalFile()).size();

    auto info = convertedSize(fileSize);

    m_sizeUnits = info.second;

    return info.first;
}

QDateTime FileInfo::creationDate(const QUrl &path) const
{
    return QFileInfo(path.toLocalFile()).birthTime();
}

bool FileInfo::isFolder(const QUrl &path) const
{
    return FolderHandler().isFolder(path);
}

QString FileInfo::sizeUnits() const
{
    return m_sizeUnits;
}

std::pair<int, QString> FileInfo::convertedSize(int fileSize)
{
    //TODO return in every if?
     std::pair<int, QString> info;

    //size in bytes
    if (fileSize < 1024) {
       info = std::pair<int, QString>(fileSize, "bytes");
    }

    //if at least one kb
    if (fileSize > 1024) {
        info = SizeConverter::bytesToKb(fileSize);
    }

    //if at least one mb
    if (fileSize > 1024 * 1024) {
        info = SizeConverter::bytesToMb(fileSize);
    }

    //if at lest one gb
    if (fileSize > 1024 * 1024 * 1024) {
        info = SizeConverter::bytesToGb(fileSize);
        qDebug() << info.first;
    }

    return info;
}
