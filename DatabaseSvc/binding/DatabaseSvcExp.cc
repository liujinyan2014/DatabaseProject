#include "boost/python.hpp"
#include "boost/noncopyable.hpp"
#include "boost/make_shared.hpp"
#include "boost/python/suite/indexing/vector_indexing_suite.hpp"
namespace bp = boost::python;
using namespace boost::python;

#include "SniperKernel/SvcBase.h"
#include "DatabaseSvc/IQuery.h"

struct IQueryWrap: IQuery, wrapper<IQuery>
{
    bool query(const QueryString& qs, QueryRecord& rs) {
        return this->get_override("query")(qs, rs);
    }

    bool insert(const RecordString& rs) {
        return this->get_override("insert")(rs);
    }

    bool update(const QueryString& qs, const RecordString& rs) {
        return this->get_override("update")(qs, rs);
    }

    bool remove(const QueryString& qs) {
        return this->get_override("remove")(qs);
    }
};

#include "MongoDB.h"

BOOST_PYTHON_MODULE(libDatabaseSvc)
{
    class_<IQuery::QueryRecord>("QueryRecord")
        .def(vector_indexing_suite<IQuery::QueryRecord>());
    class_<IQueryWrap, boost::noncopyable>("IQuery")
        .def("query", pure_virtual(&IQuery::query));
    class_<MyMongoDB, bases<IQuery, SvcBase>, boost::noncopyable>
        ("MyMongDB", init<std::string>());
}
