#-- start of make_header -----------------

#====================================
#  Library DBTest
#
#   Generated Fri Nov 14 17:01:24 2014  by liujy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_DBTest_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_DBTest_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_DBTest

DBTest_tag = $(tag)

#cmt_local_tagfile_DBTest = $(DBTest_tag)_DBTest.make
cmt_local_tagfile_DBTest = $(bin)$(DBTest_tag)_DBTest.make

else

tags      = $(tag),$(CMTEXTRATAGS)

DBTest_tag = $(tag)

#cmt_local_tagfile_DBTest = $(DBTest_tag).make
cmt_local_tagfile_DBTest = $(bin)$(DBTest_tag).make

endif

include $(cmt_local_tagfile_DBTest)
#-include $(cmt_local_tagfile_DBTest)

ifdef cmt_DBTest_has_target_tag

cmt_final_setup_DBTest = $(bin)setup_DBTest.make
cmt_dependencies_in_DBTest = $(bin)dependencies_DBTest.in
#cmt_final_setup_DBTest = $(bin)DBTest_DBTestsetup.make
cmt_local_DBTest_makefile = $(bin)DBTest.make

else

cmt_final_setup_DBTest = $(bin)setup.make
cmt_dependencies_in_DBTest = $(bin)dependencies.in
#cmt_final_setup_DBTest = $(bin)DBTestsetup.make
cmt_local_DBTest_makefile = $(bin)DBTest.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)DBTestsetup.make

#DBTest :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'DBTest'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = DBTest/
#DBTest::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

DBTestlibname   = $(bin)$(library_prefix)DBTest$(library_suffix)
DBTestlib       = $(DBTestlibname).a
DBTeststamp     = $(bin)DBTest.stamp
DBTestshstamp   = $(bin)DBTest.shstamp

DBTest :: dirs  DBTestLIB
	$(echo) "DBTest ok"

cmt_DBTest_has_prototypes = 1

#--------------------------------------

ifdef cmt_DBTest_has_prototypes

DBTestprototype :  ;

endif

DBTestcompile : $(bin)DBTest.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

DBTestLIB :: $(DBTestlib) $(DBTestshstamp)
	$(echo) "DBTest : library ok"

$(DBTestlib) :: $(bin)DBTest.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(DBTestlib) $(bin)DBTest.o
	$(lib_silent) $(ranlib) $(DBTestlib)
	$(lib_silent) cat /dev/null >$(DBTeststamp)

#------------------------------------------------------------------
#  Future improvement? to empty the object files after
#  storing in the library
#
##	  for f in $?; do \
##	    rm $${f}; touch $${f}; \
##	  done
#------------------------------------------------------------------

#
# We add one level of dependency upon the true shared library 
# (rather than simply upon the stamp file)
# this is for cases where the shared library has not been built
# while the stamp was created (error??) 
#

$(DBTestlibname).$(shlibsuffix) :: $(DBTestlib) requirements $(use_requirements) $(DBTeststamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" DBTest $(DBTest_shlibflags)
	$(lib_silent) cat /dev/null >$(DBTestshstamp)

$(DBTestshstamp) :: $(DBTestlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(DBTestlibname).$(shlibsuffix) ; then cat /dev/null >$(DBTestshstamp) ; fi

DBTestclean ::
	$(cleanup_echo) objects DBTest
	$(cleanup_silent) /bin/rm -f $(bin)DBTest.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)DBTest.o) $(patsubst %.o,%.dep,$(bin)DBTest.o) $(patsubst %.o,%.d.stamp,$(bin)DBTest.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf DBTest_deps DBTest_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
DBTestinstallname = $(library_prefix)DBTest$(library_suffix).$(shlibsuffix)

DBTest :: DBTestinstall ;

install :: DBTestinstall ;

DBTestinstall :: $(install_dir)/$(DBTestinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(DBTestinstallname) :: $(bin)$(DBTestinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(DBTestinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##DBTestclean :: DBTestuninstall

uninstall :: DBTestuninstall ;

DBTestuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(DBTestinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),DBTestclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),DBTestprototype)

$(bin)DBTest_dependencies.make : $(use_requirements) $(cmt_final_setup_DBTest)
	$(echo) "(DBTest.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)DBTest.cc -end_all $(includes) $(app_DBTest_cppflags) $(lib_DBTest_cppflags) -name=DBTest $? -f=$(cmt_dependencies_in_DBTest) -without_cmt

-include $(bin)DBTest_dependencies.make

endif
endif
endif

DBTestclean ::
	$(cleanup_silent) \rm -rf $(bin)DBTest_deps $(bin)DBTest_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),DBTestclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DBTest.d

$(bin)$(binobj)DBTest.d :

$(bin)$(binobj)DBTest.o : $(cmt_final_setup_DBTest)

$(bin)$(binobj)DBTest.o : $(src)DBTest.cc
	$(cpp_echo) $(src)DBTest.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(DBTest_pp_cppflags) $(lib_DBTest_pp_cppflags) $(DBTest_pp_cppflags) $(use_cppflags) $(DBTest_cppflags) $(lib_DBTest_cppflags) $(DBTest_cppflags) $(DBTest_cc_cppflags)  $(src)DBTest.cc
endif
endif

else
$(bin)DBTest_dependencies.make : $(DBTest_cc_dependencies)

$(bin)DBTest_dependencies.make : $(src)DBTest.cc

$(bin)$(binobj)DBTest.o : $(DBTest_cc_dependencies)
	$(cpp_echo) $(src)DBTest.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(DBTest_pp_cppflags) $(lib_DBTest_pp_cppflags) $(DBTest_pp_cppflags) $(use_cppflags) $(DBTest_cppflags) $(lib_DBTest_cppflags) $(DBTest_cppflags) $(DBTest_cc_cppflags)  $(src)DBTest.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: DBTestclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(DBTest.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

DBTestclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library DBTest
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)DBTest$(library_suffix).a $(library_prefix)DBTest$(library_suffix).$(shlibsuffix) DBTest.stamp DBTest.shstamp
#-- end of cleanup_library ---------------
