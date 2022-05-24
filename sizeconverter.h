#ifndef SIZECONVERTER_H
#define SIZECONVERTER_H

#include <utility>
#include <QString>

class SizeConverter
{
public:
    SizeConverter();

    static std::pair<int, QString> bytesToKb(int size);
    static std::pair<int, QString> bytesToMb(int size);
    static std::pair<int, QString> bytesToGb(int size);
};

#endif // SIZECONVERTER_H
