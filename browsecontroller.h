#ifndef BROWSECONTROLLER_H
#define BROWSECONTROLLER_H

#include <QStack>
#include <QString>
#include <QObject>
#include <QUrl>


class BrowseController :  public QObject
{
    Q_OBJECT;
public:
    BrowseController();

    Q_PROPERTY(QUrl current READ current WRITE setCurrent NOTIFY currentChanged)
    Q_PROPERTY(bool forwardAvaliable READ forwardAvaliable  NOTIFY forwardAvaliableChanged)
    Q_PROPERTY(bool backwardAvaliable READ backwardAvaliable  NOTIFY backwardAvaliableChanged)

    Q_INVOKABLE void addForward(const QUrl& url);
    Q_INVOKABLE void moveForward();
    Q_INVOKABLE void moveBackward();
    Q_INVOKABLE void clear();

    const QUrl& current() const          { return m_current; }
    const bool forwardAvaliable()        { return !forward.empty() || forward.size() > 1; }
    const bool backwardAvaliable()       { return backward.size() >= 1; }

    void setCurrent(const QUrl& url) {
        m_current = url;
        emit currentChanged();
    }

signals:
    void currentChanged();
    void forwardAvaliableChanged();
    void backwardAvaliableChanged();

private:
    QStack<QUrl> forward;
    QStack<QUrl> backward;
    QUrl m_current = QUrl("file:///C:/");
};

#endif // BROWSECONTROLLER_H
