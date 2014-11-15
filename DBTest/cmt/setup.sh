# echo "setup DBTest v0 in /home/liujy/mongo-client/MirguestIssueReport/Prog/cpp/DatabaseProject"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/liujy/juno/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtDBTesttempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtDBTesttempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=DBTest -version=v0 -path=/home/liujy/mongo-client/MirguestIssueReport/Prog/cpp/DatabaseProject  -no_cleanup $* >${cmtDBTesttempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=DBTest -version=v0 -path=/home/liujy/mongo-client/MirguestIssueReport/Prog/cpp/DatabaseProject  -no_cleanup $* >${cmtDBTesttempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtDBTesttempfile}
  unset cmtDBTesttempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtDBTesttempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtDBTesttempfile}
unset cmtDBTesttempfile
return $cmtsetupstatus

