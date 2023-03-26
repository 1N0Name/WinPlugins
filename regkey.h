#ifndef REGKEY_H
#define REGKEY_H


class RegKey
{
public:
    RegKey();
    inline bool isEqual(const RegKey& key) const;
    bool operator == (const RegKey& key) const;
};

#endif // REGKEY_H
