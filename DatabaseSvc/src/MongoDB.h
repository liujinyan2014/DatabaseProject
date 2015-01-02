#ifndef src_MongoDB_h
#define src_MongoDB_h

#include <DatabaseSvc/IQuery.h>
#include <SniperKernel/SvcBase.h>

namespace mongo {
    class DBClientConnection;
}

class MyMongoDB: public IQuery, public SvcBase {
public:
    MyMongoDB(const std::string& name);
    ~MyMongoDB();

    bool initialize();
    bool finalize();

      bool query(const QueryString& qs, QueryRecord& rs) ;

      bool insert(const RecordString& rs);
      bool update(const QueryString& qs, const RecordString& rs);
      bool remove(const QueryString& qs);

private:

    std::string m_hostname;
    std::string m_dbname;
    
    std::string m_user;
    std::string m_password;

    mongo::DBClientConnection* m_conn;
};

#endif
