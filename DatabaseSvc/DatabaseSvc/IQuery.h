#ifndef DB_IQuery_h
#define DB_IQuery_h

#include <string>
#include <vector>
class IQuery {
public:
    typedef std::string QueryString;
    typedef std::string RecordString;
    typedef std::vector<std::string> QueryRecord;
   // typedef bool QueryRecord;
    virtual bool query(const QueryString& qs,QueryRecord& rs ) = 0;

    virtual  bool insert(const RecordString& rs)=0;
    virtual  bool update(const QueryString& qs, const RecordString& rs)=0;
    virtual  bool remove(const QueryString& qs)=0;


    virtual ~IQuery(){};
};

#endif
