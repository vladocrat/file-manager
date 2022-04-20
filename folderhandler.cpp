#include "folderhandler.h"

#include <QDir>
#include <QDirIterator>
#include <QDebug>
#include "Utils.h"

FolderHandler::FolderHandler(){}

bool FolderHandler::deleteFolder(const QString& path)
{
    qDebug() << "path for deleting folder: " + path;
    QDir dir(Utils::formatPath(path));
    return dir.removeRecursively();
}

bool FolderHandler::createFolder(const QString& path)
{
    qDebug() << "path for creaing folder: " + path;
    QDir dir;
    return dir.mkdir(Utils::formatPath(path));
}

bool FolderHandler::moveFolder(const QString& from, const QString& to)
{
    QString _from = Utils::formatPath(from);
    QString _to = Utils::formatPath(to);
    QDir dir(_from);

    return dir.rename(_from, _to + "/" + dir.dirName());
}

bool FolderHandler::copyFolder(const QString &from, const QString &to)
{
    QString fromDir = Utils::formatPath(from);
    QString toDir = Utils::formatPath(to);

    QDir tempDir(fromDir);

    qDebug () << to + "/" + tempDir.dirName();

    if (folderExists(to + "/" + tempDir.dirName())) {
        return false;
    }

    QDirIterator it(fromDir, QDirIterator::Subdirectories);
    QDir dir(fromDir);

    const int absSourcePathLength = dir.absoluteFilePath(fromDir).length();

    while (it.hasNext()){
        it.next();
        const auto fileInfo = it.fileInfo();
        if(!fileInfo.isHidden()) {
            const QString subPathStructure = fileInfo.absoluteFilePath().mid(absSourcePathLength);
            const QString constructedAbsolutePath = toDir + subPathStructure;

            if(fileInfo.isDir()){
                dir.mkpath(constructedAbsolutePath);
            } else if(fileInfo.isFile()) {

                QFile::remove(constructedAbsolutePath);
                QFile::copy(fileInfo.absoluteFilePath(), constructedAbsolutePath);
            }
        }
    }
    return true;
}

bool FolderHandler::folderExists(const QString &path)
{
    QDir dir(Utils::formatPath(path));
    qDebug() << dir.exists();
    return dir.exists();
}

bool FolderHandler::moveUp(const QString &path)
{
    QString fullPath = Utils::formatPath(path);
    QDir dir(fullPath);
    QString folderName = dir.dirName();
    dir.cdUp();
    dir.cdUp();
    return dir.rename(fullPath, dir.absolutePath() + "/" + folderName);
}


