#include <iostream>
#include "DBTest.h"
#include "SniperKernel/AlgFactory.h"
#include "SniperKernel/SniperPtr.h"
#include "DatabaseSvc/IQuery.h"
#include "DatabaseSvc/MongoDB.h"
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
    SniperPtr<MyMongoDB> query_svc(getScope(), "MyMongoDB");
    IQuery::QueryString querystr1 = "";
    IQuery::RecordString querystr2  = "{\"name\":\"lizjing\", \"age\": 25,\"num\":20110056}";
    IQuery::QueryRecord results = query_svc->query(querystr1);
    
    LogInfo << "+ Result: " << std::endl;
    for (IQuery::QueryRecord::iterator it = results.begin();
	 it != results.end();++it) {
      LogInfo << (*it) << std::endl;
    }
    LogInfo<<"!!!!!!"<<std::endl;
    bool result;
    
    result = query_svc->insert(querystr2);

    if (result) {
        LogInfo << "insert success" << std::endl;
    }

    return true;
}

bool
DBTest::finalize() {
    return true;
}
