#ifndef OBJTYPE_H
#define OBJTYPE_H

#include <list>
#include <stdexcept>
#define YYSTYPE pobject

enum objType
{
    number,
    string,
    array,
    none
};

class pobject
{
public:
    objType type;
    const char *str;
    double dbl;
    std::list<pobject> arr;
    
    const char *toString()
    {
        switch(type)
        {
        case number: {
            char tmp[100]; sprintf(tmp, "%f", dbl); return strdup(tmp);
            break;
        }
        
        case string:
            return str;
            break;
        
        case array:{
            char tmp[1000];
            tmp[0] = '[';
            tmp[1] = '\0';
            
            for (auto &elem : arr)
            {
                strcat(tmp, elem.toString());
                strcat(tmp, ", ");
            }

            strcat(tmp, "]");
            return strdup(tmp);
            
            break;
            }
        
        case none:
            return "None";
            break;
        }
        
        throw std::runtime_error("Should not be here");
    
    }
public:
    void setDouble(double newVal)
    {
        type = number;
        dbl = newVal;
    };
    
    void setString(const char *newVal)
    {
        type = string;
        str = newVal;
    };
    
    pobject()
    {
        type = none;
    }
    
};

#endif