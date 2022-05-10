#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QDir>
#include <QDebug>
#include <QFileSystemModel>
#include <QQmlContext>
#include <memory>

#include "displayfilesystemmodel.h"
#include "browsecontroller.h"
#include "actioncontroller.h"
#include "fileinfo.h"

int main(int argc, char *argv[])
{

    QGuiApplication app(argc, argv);

    DisplayFileSystemModel::registerType();
    ActionController::registerType();
    BrowseController::registerType();
    FileInfo::registerType();

    QQmlApplicationEngine engine;

    std::unique_ptr<QFileSystemModel> fsm(new DisplayFileSystemModel(&engine));
    fsm->setRootPath(QDir::homePath());
    fsm->setResolveSymlinks(true);
    engine.rootContext()->setContextProperty("fileSystemModel", fsm.get());
    engine.rootContext()->setContextProperty("rootPathIndex", fsm->index("C:/"));

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
