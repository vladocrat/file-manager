#ifndef FILEINFO_H
#define FILEINFO_H

#include <QQmlEngine>
#include <QObject>
#include <QDateTime>

class FileInfo : public QObject
{
    Q_OBJECT
public:
    explicit FileInfo(QObject *parent = nullptr);

    Q_INVOKABLE QString name(const QUrl& path) const;
    Q_INVOKABLE int  size(const QUrl& path) const;
    Q_INVOKABLE QDateTime creationDate(const QUrl& path) const;
    Q_INVOKABLE bool isFolder(const QUrl& path) const;

    static void registerType() {
        static FileInfo fi;
        qmlRegisterSingletonInstance<FileInfo>("FileInfo", 1, 0, "FileInfo", &fi);
    }
};

#endif // FILEINFO_H
