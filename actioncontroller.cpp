#include "actioncontroller.h"

#include <QDebug>
#include <QString>

ActionController::ActionController(QObject *parent)
    : QObject{parent}
{

}

bool ActionController::moveFolder(const QUrl &from, const QUrl &to)
{
    if (!folderHandler.isFolder(to)) {
        return false;
    }

    if (folderHandler.isFolder(from)) {
        return folderHandler.moveFolder(from, to);
    }

    return folderHandler.moveFile(from, to);
}

bool ActionController::moveDirUp(const QUrl& path)
{
    return folderHandler.moveUp(path);
}

bool ActionController::createDir(const QUrl &path, bool isFolder)
{
    if (isFolder) {
        if (folderHandler.folderExists(path.toLocalFile())) {
            return false;
        }

       return folderHandler.createFolder(path);
    }

    if (folderHandler.fileExists(path)) {
        return false;
    }

    return folderHandler.createFile(path);
}

bool ActionController::replaceFolder(const QUrl &path, const QUrl& pathToReplace, bool isFolder)
{
    //TODO rework the whole system....
    if (isFolder) {
        return folderHandler.replaceFile(path, pathToReplace);
    }

    return folderHandler.replaceFile(path, pathToReplace);
}

bool ActionController::copyFolder(const QUrl &from, const QUrl &to)
{
    if (!folderHandler.isFolder(to)) {
        return false;
    }

    if (folderHandler.isFolder(from)) {
        return folderHandler.copyFolder(from, to);
    }
    return folderHandler.copyFile(from, to);
}

bool ActionController::makeCopy(const QUrl &path)
{
    //TODO
    if (folderHandler.isFolder(path)) {
        return false;
    }
    return false;
}

bool ActionController::deleteFolder(const QUrl &path)
{
    if (folderHandler.isFolder(path)) {
        return folderHandler.deleteFolder(path);
    }
    return folderHandler.deleteFile(path);
}

