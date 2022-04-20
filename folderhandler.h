#ifndef FOLDERHANDLER_H
#define FOLDERHANDLER_H

#include <QObject>
#include <QString>

class FolderHandler : public QObject
{
    Q_OBJECT;
public:
    FolderHandler();

    Q_INVOKABLE bool deleteFolder(const QString& path);
    Q_INVOKABLE bool createFolder(const QString& path);
    Q_INVOKABLE bool moveFolder(const QString& from, const QString& to);
    Q_INVOKABLE bool copyFolder(const QString& from, const QString& to);
    Q_INVOKABLE bool folderExists(const QString& path);
    Q_INVOKABLE bool moveUp(const QString& path);
};

#endif // FOLDERHANDLER_H
