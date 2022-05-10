#ifndef ACTIONCONTROLLER_H
#define ACTIONCONTROLLER_H

#include <QObject>
#include <QQmlEngine>

#include "folderhandler.h"

class ActionController : public QObject
{
    Q_OBJECT
public:
    explicit ActionController(QObject *parent = nullptr);

    Q_INVOKABLE bool moveFolder(const QUrl& from, const QUrl& to);
    Q_INVOKABLE bool moveDirUp(const QUrl& path);
    Q_INVOKABLE bool createDir(const QUrl& path, bool isFolder);
    Q_INVOKABLE bool replaceFolderFile(const QUrl &path, const QUrl& pathToReplace);
    Q_INVOKABLE bool copyFolder(const QUrl& from, const QUrl& to);
    Q_INVOKABLE bool makeCopy(const QUrl& path);
    Q_INVOKABLE bool deleteFolder(const QUrl& path);

    static void registerType() {
        static ActionController ac;
        qmlRegisterSingletonInstance<ActionController>("ActionController", 1, 0, "ActionController", &ac);
    }

private:
    FolderHandler folderHandler;
};

#endif // ACTIONCONTROLLER_H
