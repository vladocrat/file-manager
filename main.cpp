#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QDir>
#include <QDebug>
#include <QFileSystemModel>
#include <QQmlContext>

#include "displayfilesystemmodel.h"
#include "browsecontroller.h"
#include "folderhandler.h"

#include "actioncontroller.h"

int main(int argc, char *argv[])
{

    QGuiApplication app(argc, argv);


    qmlRegisterUncreatableType<DisplayFileSystemModel>("filesystembrowser", 1, 0,
                                                           "FileSystemModel", "Cannot create a FileSystemModel instance.");



    BrowseController browseController;
    FolderHandler folderHandler;
    ActionController actionController;
    qmlRegisterSingletonInstance<BrowseController>("BrowseController", 1, 0, "BrowseController", &browseController);
    qmlRegisterSingletonInstance<FolderHandler>("FolderHandler", 1, 0, "FolderHandler", &folderHandler);
    qmlRegisterSingletonInstance<ActionController>("ActionController", 1, 0, "ActionController", &actionController);

    QQmlApplicationEngine engine;

    //TODO when to delete?
    QFileSystemModel* fsm = new DisplayFileSystemModel(&engine);
    fsm->setRootPath(QDir::homePath());
    fsm->setResolveSymlinks(true);
    engine.rootContext()->setContextProperty("fileSystemModel", fsm);
    engine.rootContext()->setContextProperty("rootPathIndex", fsm->index("C:/" /*fsm->rootPath()*/));


    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
