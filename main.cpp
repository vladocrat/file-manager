#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QDir>
#include <QDebug>
#include <QFileSystemModel>
#include <QQmlContext>

#include "displayfilesystemmodel.h"
#include "browsecontroller.h"
#include "folderhandler.h"
#include "filehandler.h"


int main(int argc, char *argv[])
{

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    qmlRegisterUncreatableType<DisplayFileSystemModel>("filesystembrowser", 1, 0,
                                                           "FileSystemModel", "Cannot create a FileSystemModel instance.");


    BrowseController browseController;
   // qmlRegisterType<BrowseController>("browsecontroller", 1, 0, "BrowseController");
    qmlRegisterSingletonInstance<BrowseController>("BrowseController", 1, 0, "BrowseController", &browseController);

    qmlRegisterType<FolderHandler>("folderhandler", 1, 0, "FolderHandler");
    qmlRegisterType<FileHandler>("filehandler", 1, 0, "FileHandler");



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
