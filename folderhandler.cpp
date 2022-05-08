#include "folderhandler.h"

#include <QDir>
#include <QDirIterator>
#include <QDebug>

FolderHandler::FolderHandler(){}

bool FolderHandler::deleteFolder(const QUrl& path)
{
    qDebug() << "path for deleting folder: " + path.toLocalFile();
    QDir dir(path.toLocalFile());
    return dir.removeRecursively();
}

bool FolderHandler::createFolder(const QUrl& path)
{
    qDebug() << "path for creaing folder: " + path.toLocalFile();
    QDir dir;
    return dir.mkdir(path.toLocalFile());
}

bool FolderHandler::moveFolder(const QUrl& from, const QUrl& to)
{
    QString formatedFrom = from.toLocalFile();
    QString formatedTo = to.toLocalFile();
    QDir dir(formatedFrom);
    return dir.rename(formatedFrom, formatedTo + "/" + dir.dirName());
}

bool FolderHandler::copyFolder(const QUrl &from, const QUrl &to)
{
    //TODO copys contents but doesn't create root folder
    QString fromDir = from.toLocalFile();
    QString toDir = to.toLocalFile();

    QDir tempDir(fromDir);

    qDebug () << toDir + "/" + tempDir.dirName();

    if (folderExists(toDir + "/" + tempDir.dirName())) {
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

bool FolderHandler::folderExists(const QString& path)
{
    QDir dir(path);
    qDebug() << path;
    qDebug() << dir.exists();
    return dir.exists();
}

bool FolderHandler::moveUp(const QUrl& path)
{
    QString initialPath = path.toLocalFile();
    QDir dir(initialPath);
    QString folderName = dir.dirName();
    dir.cdUp();
    dir.cdUp();
    return dir.rename(initialPath, dir.absolutePath() + "/" + folderName);
}

bool FolderHandler::isFolder(const QUrl& path)
{
    //TODO not working when file/folder doesn't exist LOL
    QFileInfo fi(path.toLocalFile());
    return fi.isDir();
}

bool FolderHandler::createFile(const QUrl& path)
{
    qDebug() << "initial path " << path;
    qDebug() << "path for creating file: " + path.toLocalFile();
    QFile file(path.toLocalFile());
    return file.open(QIODevice::ReadWrite);
}

bool FolderHandler::deleteFile(const QUrl &path)
{
    qDebug() << "path for deleting file: " + path.toLocalFile();
    QFile file(path.toLocalFile());
    return file.remove();
}

bool FolderHandler::moveFile(const QUrl &from, const QUrl &to)
{
    QString formatedFrom = from.toLocalFile();
    QString formatedTo = to.toLocalFile();
    QFile file(formatedFrom);
    QString renamePath = formatedTo + "/" + from.fileName();
    qDebug() << "from: " + formatedFrom + " to:" + renamePath;
    return file.rename(renamePath);
}

bool FolderHandler::copyFile(const QUrl &from, const QUrl &to)
{   
    QString formatedFrom = from.toLocalFile();
    QString formatedTo = to.toLocalFile();
    qDebug() << "from: " + formatedFrom + " to:" + formatedTo;
    QDir dir(formatedFrom);
    qDebug() << "full path: " + formatedTo + "/" + dir.dirName();
    return QFile::copy(dir.absolutePath(), formatedTo + "/" + dir.dirName());
}

bool FolderHandler::replaceFile(const QUrl &filePath, const QUrl &filePathToReplace)
{
    QDir dir(filePath.toLocalFile());
    if (!deleteFile(filePathToReplace.toLocalFile() + "/" + dir.dirName())) {
        return false;
    }

    return moveFile(filePath, QUrl(filePathToReplace.toLocalFile() + "/" + dir.dirName()));
}

bool FolderHandler::fileExists(const QUrl &path)
{
    return QFile::exists(path.toLocalFile());
}




