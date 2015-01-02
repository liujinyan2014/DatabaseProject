#include <iostream>
#include "DBTest.h"
#include "SniperKernel/AlgFactory.h"
#include "SniperKernel/SniperPtr.h"
#include "DatabaseSvc/IQuery.h"
// #include "DatabaseSvc/MongoDB.h"
//using namespace mongo;
DECLARE_ALGORITHM(DBTest);

DBTest::DBTest(const std::string& name)
    : AlgBase(name)
{

}

bool
DBTest::initialize() {
    return true;
}

bool
DBTest::execute() {
    SniperPtr<IQuery> query_svc(getScope(), "MyMongoDB");
    IQuery::QueryString querystr1 = "";
    IQuery::RecordString recordstr2  = "{\"name\":\"lizjing\", \"age\": 25,\"num\":20110056}";
    IQuery::QueryString removestr3 = "{\"name\":\"lizjing\"}";
    IQuery::QueryString querystr2 = "{\"name\":\"tao\"}";
    IQuery::RecordString recordstr3 = "{\"name\":\"lintao\"}";
    
    IQuery::QueryRecord queryrecord;
    bool query = query_svc->query(querystr1,queryrecord);

    if (!query) {
        LogError << "..."<< std::endl;
        return false;
    }
    
    LogInfo << "+ Result: " << std::endl;
    for (IQuery::QueryRecord::iterator it = queryrecord.begin();
	 it != queryrecord.end();++it) {
      LogInfo << (*it) << std::endl;
    }

    
    if (query) {
        LogInfo << "query success" << std::endl;
    }
    

    LogInfo<<"!!!!!!"<<std::endl;

    
 
    bool insert;
    insert = query_svc->insert(recordstr2);

    if (insert) {
        LogInfo << "insert success" << std::endl;
    }

    bool remove;
    
    remove = query_svc->remove(removestr3);

    if (remove) {
        LogInfo << "remove success" << std::endl;
    }


 bool update;
    
    update = query_svc->update(querystr2,recordstr3);

    if (update) {
        LogInfo << "update success" << std::endl;
    }


    return true;
}


bool
DBTest::finalize() {

    return true;
}
