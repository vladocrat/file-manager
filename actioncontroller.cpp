#include "actioncontroller.h"

#include <QDebug>
#include <QString>

ActionController::ActionController(QObject *parent)
    : QObject{parent}
{

}

bool ActionController::moveFolderFile(const QUrl &from, const QUrl &to)
{
    if (!FolderHandler::isFolder(to)) {
        return false;
    }

    if (FolderHandler::isFolder(from)) {
        return folderHandler.moveFolder(from, to);
    }

    return folderHandler.moveFile(from, to);
}

bool ActionController::moveDirUp(const QUrl& path)
{
    return folderHandler.moveUp(path);
}

bool ActionController::createFolderFile(const QUrl &path, bool isFolder)
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

bool ActionController::replaceFolderFile(const QUrl &path, const QUrl& pathToReplace)
{
    return folderHandler.replaceFolderFile(path, pathToReplace);
}

bool ActionController::copyFolderFIle(const QUrl &from, const QUrl &to)
{
    if (!FolderHandler::isFolder(to)) {
        return false;
    }

    if (FolderHandler::isFolder(from)) {
        return folderHandler.copyFolder(from, to);
    }
    return folderHandler.copyFile(from, to);
}

bool ActionController::makeCopy(const QUrl &path)
{
    //TODO
    if (FolderHandler::isFolder(path)) {
        return false;
    }
    return false;
}

bool ActionController::deleteFolderFile(const QUrl &path)
{
    if (FolderHandler::isFolder(path)) {
        return folderHandler.deleteFolder(path);
    }
    return folderHandler.deleteFile(path);
}

