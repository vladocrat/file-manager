#ifndef FILEHANDLER_H
#define FILEHANDLER_H

#include <QObject>

class FileHandler : public QObject
{
    Q_OBJECT;
public:
    FileHandler();

    Q_INVOKABLE bool createFile(const QString& path);
    Q_INVOKABLE bool deleteFile(const QString& path);
    Q_INVOKABLE bool moveFile(const QString& from, const QString& to);
    Q_INVOKABLE bool copyFile(const QString& from, const QString& to);
    Q_INVOKABLE bool replaceFile(const QString& filePath, const QString& filePathToReplace);
    Q_INVOKABLE bool fileExists(const QString& path);
    Q_INVOKABLE bool moveUp(const QString& path);


};

#endif // FILEHANDLER_H
