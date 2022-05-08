#ifndef FOLDERHANDLER_H
#define FOLDERHANDLER_H

#include <QObject>
#include <QString>
#include <QUrl>

class FolderHandler : public QObject
{
    Q_OBJECT;
public:
    FolderHandler();

    //files
    Q_INVOKABLE bool deleteFolder(const QUrl& path);
    Q_INVOKABLE bool createFolder(const QUrl& path);
    Q_INVOKABLE bool moveFolder(const QUrl& from, const QUrl& to);
    Q_INVOKABLE bool copyFolder(const QUrl& from, const QUrl& to);
    bool folderExists(const QString& path);
    Q_INVOKABLE bool moveUp(const QUrl& path);
    bool isFolder(const QUrl& path);

    //files
    Q_INVOKABLE bool createFile(const QUrl& path);
    Q_INVOKABLE bool deleteFile(const QUrl& path);
    Q_INVOKABLE bool moveFile(const QUrl& from, const QUrl& to);
    Q_INVOKABLE bool copyFile(const QUrl& from, const QUrl& to);
    Q_INVOKABLE bool replaceFile(const QUrl& filePath, const QUrl& filePathToReplace);
    Q_INVOKABLE bool fileExists(const QUrl& path);

};

#endif // FOLDERHANDLER_H
