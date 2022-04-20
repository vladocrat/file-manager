#include "filehandler.h"

#include <QFile>
#include <QDir>
#include <QDebug>

#include "Utils.h"

FileHandler::FileHandler()
{

}

bool FileHandler::createFile(const QString &path)
{
    qDebug() << "path for creating file: " + path;
    QFile file(Utils::formatPath(path));
    return file.open(QIODevice::ReadWrite);
}

bool FileHandler::deleteFile(const QString &path)
{
    qDebug() << "path for deleting file: " + path;
    QFile file(Utils::formatPath(path));
    return file.remove();
}

bool FileHandler::moveFile(const QString &from, const QString &to)
{
    qDebug() << "from: " + from + " to:" + to;

    QFile file(Utils::formatPath(from));
    return file.rename(Utils::formatPath(to));
}

bool FileHandler::copyFile(const QString &from, const QString &to)
{
    qDebug() << "from: " + from + " to:" + to;

    QDir dir(Utils::formatPath(from));

    qDebug() << "full path: " +  Utils::formatPath(to) + "/" + dir.dirName();
    return QFile::copy(dir.absolutePath(), Utils::formatPath(to) + "/" + dir.dirName());
}

bool FileHandler::replaceFile(const QString &filePath, const QString &filePathToReplace)
{
    QDir dir(filePath);
    //passing strings without formating coz funcs format them
    if (!deleteFile(filePathToReplace + "/" + dir.dirName())) {
        return false;
    }

    return moveFile(filePath, filePathToReplace + "/" + dir.dirName());
}

bool FileHandler::fileExists(const QString &path)
{
    return QFile::exists(Utils::formatPath(path));
}

bool FileHandler::moveUp(const QString &path)
{
    QString filePath = Utils::formatPath(path);
    QDir dir(filePath);
    QString fileName = dir.dirName();
    dir.cdUp();
    dir.cdUp();
    return QFile::rename(filePath, dir.absolutePath() + "/" + fileName);
}
