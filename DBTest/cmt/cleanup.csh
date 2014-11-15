# echo "cleanup DBTest v0 in /home/liujy/mongo-client/MirguestIssueReport/Prog/cpp/DatabaseProject"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /home/liujy/juno/ExternalLibs/CMT/v1r26
endif
source ${CMTROOT}/mgr/setup.csh
set cmtDBTesttempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtDBTesttempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt cleanup -csh -pack=DBTest -version=v0 -path=/home/liujy/mongo-client/MirguestIssueReport/Prog/cpp/DatabaseProject  $* >${cmtDBTesttempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt cleanup -csh -pack=DBTest -version=v0 -path=/home/liujy/mongo-client/MirguestIssueReport/Prog/cpp/DatabaseProject  $* >${cmtDBTesttempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtDBTesttempfile}
  unset cmtDBTesttempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtDBTesttempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtDBTesttempfile}
unset cmtDBTesttempfile
exit $cmtcleanupstatus

