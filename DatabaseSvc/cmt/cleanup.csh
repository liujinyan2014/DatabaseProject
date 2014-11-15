# echo "cleanup DatabaseSvc v0 in /home/liujy/mongo-client/MirguestIssueReport/Prog/cpp/DatabaseProject"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /home/liujy/juno/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtDatabaseSvctempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtDatabaseSvctempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt cleanup -csh -pack=DatabaseSvc -version=v0 -path=/home/liujy/mongo-client/MirguestIssueReport/Prog/cpp/DatabaseProject  $* >${cmtDatabaseSvctempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt cleanup -csh -pack=DatabaseSvc -version=v0 -path=/home/liujy/mongo-client/MirguestIssueReport/Prog/cpp/DatabaseProject  $* >${cmtDatabaseSvctempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtDatabaseSvctempfile}
  unset cmtDatabaseSvctempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtDatabaseSvctempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtDatabaseSvctempfile}
unset cmtDatabaseSvctempfile
exit $cmtcleanupstatus

