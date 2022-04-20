#ifndef UTILS_H
#define UTILS_H

#include <QString>
#include <QDebug>

class Utils {
public:
    static QString formatPath(const QString& path) {
        QString newPath = path;
        newPath.remove(0, 8);
        qDebug() << "formated path: " + newPath;
        return newPath;
    }
};

#endif // UTILS_H
