#include "browsecontroller.h"

#include <QDebug>

BrowseController::BrowseController()
{
    m_current.setUrl("file:///");
}

void BrowseController::addForward(const QUrl& url)
{
    if (url.fileName() != "") {
        backward.append(m_current);
        emit backwardAvaliableChanged();
    }
    m_current = url;
    emit currentChanged();
}

void BrowseController::moveForward()
{
    if (forward.empty() || m_current == forward.top()) {
        return;
    } else {
        backward.append(m_current);
        m_current = forward.top();
        forward.pop();
        emit backwardAvaliableChanged();
        emit forwardAvaliableChanged();
        emit currentChanged();
    }
}

void BrowseController::moveBackward()
{
    if (backward.empty() || m_current == backward.top()) {
        return;
    } else {
        forward.append(m_current);
        m_current = backward.top();
        backward.pop();
        emit forwardAvaliableChanged();
        emit backwardAvaliableChanged();
        emit currentChanged();
    }
}

void BrowseController::clear()
{
    backward.clear();
    forward.clear();
    m_current.setUrl("");
}
