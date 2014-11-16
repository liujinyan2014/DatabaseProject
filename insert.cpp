
#include "mongo/client/dbclient.h"

#include <iostream>
#include <cstdlib>
using namespace std;
using namespace mongo;



/*执行写一个打印名称的函数（惟一的）的所有students在收集他们的年龄是一个给定的值*/
int printIfXuehao(DBClientConnection& c, int xuehao) {
    std::auto_ptr<DBClientCursor> cursor = c.query("mydb.testData", MONGO_QUERY( "xuehao" << xuehao ).sort("name") );
    if (!cursor.get()) {
        cout << "query failure" << endl;
        return EXIT_FAILURE;
    }

    while( cursor->more() ) {
        BSONObj p = cursor->next();
        cout << p.getStringField("name") << endl;
    }


    return EXIT_SUCCESS;
}



int run(int argc, char* argv[]) {

    const char *port = "27017";
    if ( argc != 1 ) {
        if ( argc != 3 ) {
            std::cout << "need to pass port as second param" << endl;
            return EXIT_FAILURE;
        }
        port = argv[ 2 ];
    }




     mongo::DBClientConnection c;
    c.connect(string("localhost:") + port);
    cout << "connected ok" << endl;






    BSONObj p = BSON( "name" << "yan" << "xuehao" << 11 );
    c.insert("mydb.testData", p);
    p = BSON( "name" << "teng" << "xuehao" << 02 );
    c.insert("mydb.testData", p);
    p = BSON( "name" << "tao" << "xuehao" << 03 );
    c.insert("mydb.testData", p);
    p = BSON( "name" << "mengt" << "xuehao" << BSONNULL);
    c.insert("mydb.testData", p);
    p = BSON( "name" << "hxt" << "age" << 38 << "city" << "Ji Nan" << "state" << "Pro" );
    c.insert("mydb.testData", p);
    p = BSON( "name" << "Ycx" << "age" << 50 << "city" << "Tian Jin" << "state" << "Pro" );
    c.insert("mydb.testData", p);

    c.createIndex("mydb.testData", fromjson("{age:2}"));
    //c.createIndex("lianxi0.people", fromjson("{age:1}"));


    cout << "count:" << c.count("mydb.testData") << endl;
   // cout << "count:" << c.count("lianxi0.people") << endl;

    std::auto_ptr<DBClientCursor> cursor = c.query("mydb.testData", BSONObj());
    if (!cursor.get()) {
        cout << "query failure" << endl;
        return EXIT_FAILURE;
    }

    while( cursor->more() ) {
        cout << cursor->next().toString() << endl;
    }

    cout << "\nprintifXuehao:\n";

    return printIfXuehao(c, 11);
}



 
int main(int argc, char* argv[]){



 
 
mongo::DBClientConnection c;  
mongo::client::GlobalInstance instance;
    if (!instance.initialized()) {
        std::cout << "failed to initialize the client driver: " << instance.status() << endl;
        return EXIT_FAILURE;
    }

    int ret = EXIT_SUCCESS;
    try {
        ret = run(argc, argv);
    }
    catch( DBException &e ) {
        cout << "caught " << e.what() << endl;
        ret = EXIT_FAILURE;
    } 


  mongo::BSONObjBuilder query;
       // c.remove( "lianxi0.people" , query.obj() );
    
   BSONObj p = BSON( "name" << "Zhangsan" << "xuehao" << 0741 );
    c.insert("mydb.testData", p);
    p = BSON( "name" << "Lisi" << "xuehao" << 0123 );
    c.insert("mydb.testData", p);  
 {
        mongo::BSONObjBuilder query;
        std::auto_ptr<mongo::DBClientCursor> cursor = c.query( "mydb.testData" , query.obj() );
        if (!cursor.get()) {
            cout << "query failure" << endl;
            return EXIT_FAILURE;
        }

        cout << "using cursor" << endl;
        while ( cursor->more() ) {
            mongo::BSONObj obj = cursor->next();
            cout << "\t" << obj.jsonString() << endl;
        }

    }




    {
        mongo::BSONObjBuilder query;
        query.append( "name" , "Zhangsan" );
        mongo::BSONObj res = c.findOne( "mydb.testData" , query.obj() );
        cout << res.isEmpty() << "\t" << res.jsonString() << endl;
    }

    {
        mongo::BSONObjBuilder query;
        query.append( "age" , 38 );
        mongo::BSONObj res = c.findOne( "mydb.testData" , query.obj() );
        cout << res.isEmpty() << "\t" << res.jsonString() << endl;
    }


 {
        mongo::BSONObjBuilder query;
        query.append( "xuehao" , 69 );
        query.append( "city" , "Ji Nan"  );
        mongo::BSONObj res = c.findOne( "mydb.testData" , query.obj() );
        cout << res.isEmpty() << "\t" << res.jsonString() << endl;
    }


    return ret;
}
