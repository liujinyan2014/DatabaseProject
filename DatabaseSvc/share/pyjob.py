#!/usr/bin/env python
# -*- coding:utf-8 -*-
# author: lintao


import Sniper

if __name__ == "__main__":

    task = Sniper.Task("task")
    task.setEvtMax(1)
    task.setLogLevel(2)

    Sniper.loadDll("libDatabaseSvc.so")
    import libDatabaseSvc
    dbsvc = task.createSvc("MyMongoDB")
    dbsvc.initialize()
    print dbsvc
    # assume we can query directly
    record = libDatabaseSvc.QueryRecord();
    dbsvc.query("", record)
    import json
    for r in  record:
        print json.loads(r)

    r = json.dumps({'x':'liu'})
    print dbsvc.insert(r)

    # load PMT theta and phi
    import os
    detroot = os.environ["DETSIMOPTIONSROOT"] 
    cdpmt = os.path.join(detroot, "data",
            "PMTPos_Acrylic.csv")
    if (not os.path.exists(cdpmt)):
        raise Exception("can't find the PMT file %s, please setup env."%cdpmt)
    with open(cdpmt) as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            no, theta, phi = line.split()
            print theta, phi
            r = json.dumps({'theta':theta, 'phi':phi})
            print dbsvc.insert(r)

    # end
    dbsvc.finalize()
