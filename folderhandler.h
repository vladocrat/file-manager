#ifndef FOLDERHANDLER_H
#define FOLDERHANDLER_H

#include <QString>
#include <QUrl>

class FolderHandler
{
public:
    FolderHandler();

    //files
    bool deleteFolder(const QUrl& path);
    bool createFolder(const QUrl& path);
    bool moveFolder(const QUrl& from, const QUrl& to);
    bool copyFolder(const QUrl& from, const QUrl& to);
    bool folderExists(const QString& path);
    bool moveUp(const QUrl& path);
    bool isFolder(const QUrl& path);

    //files
    bool createFile(const QUrl& path);
    bool deleteFile(const QUrl& path);
    bool moveFile(const QUrl& from, const QUrl& to);
    bool copyFile(const QUrl& from, const QUrl& to);
    bool replaceFolderFile(const QUrl& filePath, const QUrl& filePathToReplace);
    bool fileExists(const QUrl& path);
};

#endif // FOLDERHANDLER_H
