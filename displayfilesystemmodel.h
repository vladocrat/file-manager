#ifndef DISPLAYFILESYSTEMMODEL_H
#define DISPLAYFILESYSTEMMODEL_H

#include <QDir>
#include <QFileSystemModel>

class DisplayFileSystemModel : public QFileSystemModel {
    Q_OBJECT
public:
    explicit DisplayFileSystemModel(QObject *parent = nullptr);

    enum Roles  {
        SizeRole = Qt::UserRole + 4,
        DisplayableFilePermissionsRole = Qt::UserRole + 5,
        LastModifiedRole = Qt::UserRole + 6,
        UrlStringRole = Qt::UserRole + 7
    };
    Q_ENUM(Roles);

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int,QByteArray> roleNames() const override;
};

#endif // DISPLAYFILESYSTEMMODEL_H
