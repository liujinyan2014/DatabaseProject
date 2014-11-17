#include <mongo/client/dbclient.h>
#include "DatabaseSvc/MongoDB.h"
#include <iostream>

#include "SniperKernel/SvcFactory.h"
#include "SniperKernel/SniperLog.h"
#include <boost/scoped_ptr.hpp>


using namespace std;
using namespace mongo;
using std::cout;
using std::endl;
using std::string;

DECLARE_SERVICE(MyMongoDB);

MyMongoDB::MyMongoDB(const std::string& name)
  : SvcBase(name), m_conn(0)
{
    declProp("Hostname", m_hostname = "localhost");
    declProp("DBName", m_dbname = "mydb.testData");
    declProp("user", m_user="juno");
    declProp("pwd", m_password="jiangmen");

} 

MyMongoDB::~MyMongoDB() {
    std::cout << "MyMongoDB::~MyMongoDB() Begin" << std::endl;
    if (m_conn) {
        delete m_conn;
    }
    std::cout << "MyMongoDB::~MyMongoDB() End" << std::endl;
}
//const std::string& command, 
MyMongoDB::QueryResult 
MyMongoDB::query( const MyMongoDB::QueryString& qs) {
    

    MyMongoDB::QueryResult result;
    
    std::auto_ptr<mongo::DBClientCursor> cursor = m_conn->query(
                                          m_dbname, 
                                          mongo::fromjson(qs));

    if (!cursor.get()) {
        cout << "query failure" << endl;
      
    }
    cout << "using cursor" << endl;
    while ( cursor->more() ) {
        mongo::BSONObj obj = cursor->next();
        result.push_back(obj.jsonString());
    }

    return result;

} 

bool 
MyMongoDB::insert( const MyMongoDB::QueryString& qs) {
  m_conn->insert( m_dbname, mongo::fromjson(qs));

  return true;
}

bool
MyMongoDB::remove( const MyMongoDB::QueryString& qs){

  m_conn->remove(m_dbname,mongo::fromjson(qs));

return true;
}

bool 
MyMongoDB::update( const MyMongoDB::QueryString& qs){

  m_conn->update(m_dbname,BSONObj(),mongo::fromjson(qs));

return true;
}

bool
MyMongoDB::initialize() {

    mongo::client::initialize();
    m_conn = new mongo::DBClientConnection;
    m_conn->connect(m_hostname);

     /* std::string errmsg;
    ConnectionString cs = ConnectionString::parse("127.0.0.1:27017", errmsg);
    if (!cs.isValid()) {
     cout << "error parsing url: " << errmsg << endl;
     return false;
    }

    boost::scoped_ptr<DBClientBase> m_conn(cs.connect(errmsg));
      if (!m_conn) {
           cout << "couldn't connect: " << errmsg << endl;
        return false;
     }

   if (!m_conn->auth("test", "juno", "jiangmen", errmsg)) {
        cout << "Authentication failed, when it should have succeeded. Got error: " << errmsg << endl;
        return false;
    } */

    return true;
}


bool
MyMongoDB::finalize() {

 
return true;
}

