#-- start of make_header -----------------

#====================================
#  Library DatabaseSvc
#
#   Generated Sat Nov 15 08:21:52 2014  by liujy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_DatabaseSvc_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_DatabaseSvc_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_DatabaseSvc

DatabaseSvc_tag = $(tag)

#cmt_local_tagfile_DatabaseSvc = $(DatabaseSvc_tag)_DatabaseSvc.make
cmt_local_tagfile_DatabaseSvc = $(bin)$(DatabaseSvc_tag)_DatabaseSvc.make

else

tags      = $(tag),$(CMTEXTRATAGS)

DatabaseSvc_tag = $(tag)

#cmt_local_tagfile_DatabaseSvc = $(DatabaseSvc_tag).make
cmt_local_tagfile_DatabaseSvc = $(bin)$(DatabaseSvc_tag).make

endif

include $(cmt_local_tagfile_DatabaseSvc)
#-include $(cmt_local_tagfile_DatabaseSvc)

ifdef cmt_DatabaseSvc_has_target_tag

cmt_final_setup_DatabaseSvc = $(bin)setup_DatabaseSvc.make
cmt_dependencies_in_DatabaseSvc = $(bin)dependencies_DatabaseSvc.in
#cmt_final_setup_DatabaseSvc = $(bin)DatabaseSvc_DatabaseSvcsetup.make
cmt_local_DatabaseSvc_makefile = $(bin)DatabaseSvc.make

else

cmt_final_setup_DatabaseSvc = $(bin)setup.make
cmt_dependencies_in_DatabaseSvc = $(bin)dependencies.in
#cmt_final_setup_DatabaseSvc = $(bin)DatabaseSvcsetup.make
cmt_local_DatabaseSvc_makefile = $(bin)DatabaseSvc.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)DatabaseSvcsetup.make

#DatabaseSvc :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'DatabaseSvc'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = DatabaseSvc/
#DatabaseSvc::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

DatabaseSvclibname   = $(bin)$(library_prefix)DatabaseSvc$(library_suffix)
DatabaseSvclib       = $(DatabaseSvclibname).a
DatabaseSvcstamp     = $(bin)DatabaseSvc.stamp
DatabaseSvcshstamp   = $(bin)DatabaseSvc.shstamp

DatabaseSvc :: dirs  DatabaseSvcLIB
	$(echo) "DatabaseSvc ok"

cmt_DatabaseSvc_has_prototypes = 1

#--------------------------------------

ifdef cmt_DatabaseSvc_has_prototypes

DatabaseSvcprototype :  ;

endif

DatabaseSvccompile : $(bin)MongoDB.o $(bin)DatabaseSvcExp.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

DatabaseSvcLIB :: $(DatabaseSvclib) $(DatabaseSvcshstamp)
	$(echo) "DatabaseSvc : library ok"

$(DatabaseSvclib) :: $(bin)MongoDB.o $(bin)DatabaseSvcExp.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(DatabaseSvclib) $(bin)MongoDB.o $(bin)DatabaseSvcExp.o
	$(lib_silent) $(ranlib) $(DatabaseSvclib)
	$(lib_silent) cat /dev/null >$(DatabaseSvcstamp)

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

$(DatabaseSvclibname).$(shlibsuffix) :: $(DatabaseSvclib) requirements $(use_requirements) $(DatabaseSvcstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" DatabaseSvc $(DatabaseSvc_shlibflags)
	$(lib_silent) cat /dev/null >$(DatabaseSvcshstamp)

$(DatabaseSvcshstamp) :: $(DatabaseSvclibname).$(shlibsuffix)
	$(lib_silent) if test -f $(DatabaseSvclibname).$(shlibsuffix) ; then cat /dev/null >$(DatabaseSvcshstamp) ; fi

DatabaseSvcclean ::
	$(cleanup_echo) objects DatabaseSvc
	$(cleanup_silent) /bin/rm -f $(bin)MongoDB.o $(bin)DatabaseSvcExp.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)MongoDB.o $(bin)DatabaseSvcExp.o) $(patsubst %.o,%.dep,$(bin)MongoDB.o $(bin)DatabaseSvcExp.o) $(patsubst %.o,%.d.stamp,$(bin)MongoDB.o $(bin)DatabaseSvcExp.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf DatabaseSvc_deps DatabaseSvc_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
DatabaseSvcinstallname = $(library_prefix)DatabaseSvc$(library_suffix).$(shlibsuffix)

DatabaseSvc :: DatabaseSvcinstall ;

install :: DatabaseSvcinstall ;

DatabaseSvcinstall :: $(install_dir)/$(DatabaseSvcinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(DatabaseSvcinstallname) :: $(bin)$(DatabaseSvcinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(DatabaseSvcinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##DatabaseSvcclean :: DatabaseSvcuninstall

uninstall :: DatabaseSvcuninstall ;

DatabaseSvcuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(DatabaseSvcinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),DatabaseSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),DatabaseSvcprototype)

$(bin)DatabaseSvc_dependencies.make : $(use_requirements) $(cmt_final_setup_DatabaseSvc)
	$(echo) "(DatabaseSvc.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)MongoDB.cc ../binding/DatabaseSvcExp.cc -end_all $(includes) $(app_DatabaseSvc_cppflags) $(lib_DatabaseSvc_cppflags) -name=DatabaseSvc $? -f=$(cmt_dependencies_in_DatabaseSvc) -without_cmt

-include $(bin)DatabaseSvc_dependencies.make

endif
endif
endif

DatabaseSvcclean ::
	$(cleanup_silent) \rm -rf $(bin)DatabaseSvc_deps $(bin)DatabaseSvc_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),DatabaseSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MongoDB.d

$(bin)$(binobj)MongoDB.d :

$(bin)$(binobj)MongoDB.o : $(cmt_final_setup_DatabaseSvc)

$(bin)$(binobj)MongoDB.o : $(src)MongoDB.cc
	$(cpp_echo) $(src)MongoDB.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(DatabaseSvc_pp_cppflags) $(lib_DatabaseSvc_pp_cppflags) $(MongoDB_pp_cppflags) $(use_cppflags) $(DatabaseSvc_cppflags) $(lib_DatabaseSvc_cppflags) $(MongoDB_cppflags) $(MongoDB_cc_cppflags)  $(src)MongoDB.cc
endif
endif

else
$(bin)DatabaseSvc_dependencies.make : $(MongoDB_cc_dependencies)

$(bin)DatabaseSvc_dependencies.make : $(src)MongoDB.cc

$(bin)$(binobj)MongoDB.o : $(MongoDB_cc_dependencies)
	$(cpp_echo) $(src)MongoDB.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(DatabaseSvc_pp_cppflags) $(lib_DatabaseSvc_pp_cppflags) $(MongoDB_pp_cppflags) $(use_cppflags) $(DatabaseSvc_cppflags) $(lib_DatabaseSvc_cppflags) $(MongoDB_cppflags) $(MongoDB_cc_cppflags)  $(src)MongoDB.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),DatabaseSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DatabaseSvcExp.d

$(bin)$(binobj)DatabaseSvcExp.d :

$(bin)$(binobj)DatabaseSvcExp.o : $(cmt_final_setup_DatabaseSvc)

$(bin)$(binobj)DatabaseSvcExp.o : ../binding/DatabaseSvcExp.cc
	$(cpp_echo) ../binding/DatabaseSvcExp.cc
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(DatabaseSvc_pp_cppflags) $(lib_DatabaseSvc_pp_cppflags) $(DatabaseSvcExp_pp_cppflags) $(use_cppflags) $(DatabaseSvc_cppflags) $(lib_DatabaseSvc_cppflags) $(DatabaseSvcExp_cppflags) $(DatabaseSvcExp_cc_cppflags) -I../binding ../binding/DatabaseSvcExp.cc
endif
endif

else
$(bin)DatabaseSvc_dependencies.make : $(DatabaseSvcExp_cc_dependencies)

$(bin)DatabaseSvc_dependencies.make : ../binding/DatabaseSvcExp.cc

$(bin)$(binobj)DatabaseSvcExp.o : $(DatabaseSvcExp_cc_dependencies)
	$(cpp_echo) ../binding/DatabaseSvcExp.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(DatabaseSvc_pp_cppflags) $(lib_DatabaseSvc_pp_cppflags) $(DatabaseSvcExp_pp_cppflags) $(use_cppflags) $(DatabaseSvc_cppflags) $(lib_DatabaseSvc_cppflags) $(DatabaseSvcExp_cppflags) $(DatabaseSvcExp_cc_cppflags) -I../binding ../binding/DatabaseSvcExp.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: DatabaseSvcclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(DatabaseSvc.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

DatabaseSvcclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library DatabaseSvc
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)DatabaseSvc$(library_suffix).a $(library_prefix)DatabaseSvc$(library_suffix).$(shlibsuffix) DatabaseSvc.stamp DatabaseSvc.shstamp
#-- end of cleanup_library ---------------
