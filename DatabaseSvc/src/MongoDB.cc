#include <mongo/client/dbclient.h>
#include "MongoDB.h"
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
  : SvcBase(name), m_hostname("localhost"), m_conn(0){
    mongo::client::initialize();
    declProp("Hostname", m_hostname);
    declProp("DBName", m_dbname = "mydb.testData");
    declProp("user", m_user="juno");
    declProp("pwd", m_password="jiangmen");

    mongo::DBClientConnection m_conn;

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
    
    //if (command == "query") {

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
//}

   // if (command == "insert") {}
} 

bool
MyMongoDB::initialize() {

    m_conn = new mongo::DBClientConnection;
    m_conn->connect(m_hostname);

    std::string errmsg;
    ConnectionString cs = ConnectionString::parse("localhost:27017", errmsg);
    if (!cs.isValid()) {
     cout << "error parsing url: " << errmsg << endl;
     return false;
    }

    boost::scoped_ptr<DBClientBase> m_conn(cs.connect(errmsg));
      if (!m_conn) {
            cout << "couldn't connect: " << errmsg << endl;
        return false;
     }

    bool worked;
    BSONObj ret;
// clean up old data from any previous tests
 
   worked = m_conn->runCommand( "test", BSON("dropAllUsersFromDatabase" << 1), ret );
   if (!worked) {
       cout << "Running MongoDB < 2.5.3 so falling back to old remove" << endl;
       m_conn->remove( "test.system.users" , BSONObj() );
    }

// create a new user
    worked = m_conn->runCommand( "test",
         BSON( "createUser" << "juno" <<
               "pwd" << "jiangmen" <<
               "roles" << BSON_ARRAY("readWrite")), ret);

    if (!worked) {
        cout << "Running MongoDB < 2.5.3 so falling back to old user creation" << endl;
        m_conn->insert( "test.system.users" , BSON( "user" <<
                      "juno" << "pwd" << m_conn->createPasswordDigest( "juno" , "jiangmen" ) ) );
   }

errmsg.clear();
if (!m_conn->auth("test", "juno", "jiangmen", errmsg)) {
cout << "Authentication failed, when it should have succeeded. Got error: " << errmsg << endl;
return false;
}

if (m_conn->auth("test", "juno", "jiangmen", errmsg)) { // incorrect password
cout << "Authentication with invalid password should have failed but didn't" << endl;
return false;
}
return true;
}


    /*bool result = m_conn->auth(m_dbname, m_user, m_password, errmsg, 1);
    if (!result) {
        LogError << "Database: " << m_dbname 
                 << " authentication failed: " << errmsg << std::endl;
        return false;
    }

    return true;
   
} */

bool
MyMongoDB::finalize() {

 /* BSONObj info;

  bool result = m_conn->logout("juno",info)

      {
        authCache.erase(juno);
        runCommand(dbname, BSON("logout" << 1), info);
       
if(!result){

       LogError<<"Database: "<<m_dbname
            <<"juno connect "<< info <<std::endl;
     return false;
           }
return true;
} */
return true;
}

