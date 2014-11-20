#include <mongo/client/dbclient.h>
#include "DatabaseSvc/MongoDB.h"
#include <iostream>

#include "SniperKernel/SvcFactory.h"
#include "SniperKernel/SniperLog.h"
#include <boost/scoped_ptr.hpp>


using namespace std;
using namespace mongo;

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
bool
MyMongoDB::query( const MyMongoDB::QueryString& qs, MyMongoDB::QueryRecord& rs ) {
    

    MyMongoDB::QueryRecord result;
    
    std::auto_ptr<mongo::DBClientCursor> cursor = m_conn->query(
                                          m_dbname, 
                                          mongo::fromjson(qs));

    if (!cursor.get()) {
        LogError << "query failure" << endl;
        return false;
    }
   
    while ( cursor->more() ) {
        mongo::BSONObj obj = cursor->next();
        result.push_back(obj.jsonString());
    }

   rs = result;
   return true;

} 

bool
MyMongoDB::insert(const MyMongoDB::RecordString& rs) {
  
    m_conn->insert( m_dbname, mongo::fromjson(rs));

    std::string e = m_conn->getLastError();
  if( !e.empty() ) {
        LogError << "insert failed: " << e << endl;
       return false;
    }

  return true;
}

bool
MyMongoDB::remove( const MyMongoDB::QueryString& qs){

   m_conn->remove(m_dbname,mongo::fromjson(qs));
   std::string e = m_conn->getLastError();
  if( !e.empty() ) {
       LogError << "remove failed: " << e << endl;
       return false;
    }
 
  return true;
}

bool 
MyMongoDB::update( const QueryString& qs, const RecordString& rs){
  
  m_conn->update(m_dbname ,mongo::fromjson(qs),mongo::fromjson(rs));
  
   std::string e = m_conn->getLastError();
  if( !e.empty() ) {
       LogError << "update failed: " << e << endl;
       return false;
    }

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

