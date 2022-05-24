#include "sizeconverter.h"

SizeConverter::SizeConverter()
{

}

std::pair<int, QString> SizeConverter::bytesToKb(int size)
{
    return std::pair<int, QString>(size / 1024, "kb");
}

std::pair<int, QString> SizeConverter::bytesToMb(int size)
{
    return std::pair<int, QString>(bytesToKb(size).first / 1024, "mb");
}

std::pair<int, QString> SizeConverter::bytesToGb(int size)
{
    return std::pair<int, QString>(bytesToMb(size).first / 1024, "gb");
}
