#ifndef BROWSECONTROLLER_H
#define BROWSECONTROLLER_H

#include <QStack>
#include <QString>
#include <QObject>

class BrowseController : public QObject
{
    Q_OBJECT;
public:
    BrowseController();

    Q_INVOKABLE void addForward(const QString& url);//when steped in manually
    Q_INVOKABLE QString moveForward(const QString& url);
    Q_INVOKABLE QString moveBackward(const QString& url);

private:
    QStack<QString> forward;
    QStack<QString> backward;
};

#endif // BROWSECONTROLLER_H
