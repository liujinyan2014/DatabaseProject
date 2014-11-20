pushd /home/liujy/juno/
source setup.sh
popd
export CMTPATH=/home/liujy/DatabaseProject:$CMTPATH
export MONGOHOME=/home/liujy/test/mongo-cxx-driver/mongo-client-install
export LD_LIBRARY_PATH=$MONGOHOME/lib::$LD_LIBRARY_PATH
