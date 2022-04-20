#include "browsecontroller.h"

#include <QDebug>

BrowseController::BrowseController()
{

}

//not with button
void BrowseController::addForward(const QString &url)
{
    backward.append(url);
}

QString BrowseController::moveForward(const QString& url)
{
    if (!forward.empty()) {
        backward.append(url);
        return forward.pop();
    }
    return url;
}


QString BrowseController::moveBackward(const QString& url)
{
    if (!backward.empty()) {
        forward.append(url);
        return backward.pop();
    }
    return url;
}
