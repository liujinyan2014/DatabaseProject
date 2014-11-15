# echo "cleanup DBTest v0 in /home/liujy/mongo-client/MirguestIssueReport/Prog/cpp/DatabaseProject"

if test "${CMTROOT}" = ""; then
  CMTROOT=/home/liujy/juno/ExternalLibs/CMT/v1r26; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtDBTesttempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtDBTesttempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt cleanup -sh -pack=DBTest -version=v0 -path=/home/liujy/mongo-client/MirguestIssueReport/Prog/cpp/DatabaseProject  $* >${cmtDBTesttempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt cleanup -sh -pack=DBTest -version=v0 -path=/home/liujy/mongo-client/MirguestIssueReport/Prog/cpp/DatabaseProject  $* >${cmtDBTesttempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtDBTesttempfile}
  unset cmtDBTesttempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtDBTesttempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtDBTesttempfile}
unset cmtDBTesttempfile
return $cmtcleanupstatus

