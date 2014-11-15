----------> uses
# use SniperKernel v*  (no_version_directory)
#   use SniperPolicy v*  (no_version_directory)
#   use Boost v* Externals (no_version_directory)
#     use Python v* Externals (no_version_directory)
# use DatabaseSvc *  (no_version_directory)
#   use SniperKernel v*  (no_version_directory)
#   use Boost v* Externals (no_version_directory)
#
# Selection :
use CMT v1r26 (/home/liujy/juno/ExternalLibs)
use Python v0 Externals (/home/liujy/juno/ExternalInterface)
use Boost v0 Externals (/home/liujy/juno/ExternalInterface)
use SniperPolicy v0  (/home/liujy/juno/sniper)
use SniperKernel v2  (/home/liujy/juno/sniper)
use DatabaseSvc v0  (/home/liujy/mongo-client/MirguestIssueReport/Prog/cpp/DatabaseProject)
----------> tags
CMTv1 (from CMTVERSION)
CMTr26 (from CMTVERSION)
CMTp0 (from CMTVERSION)
Linux (from uname) package [CMT] implies [Unix]
Linux-x86_64 (from CMTCONFIG)
cpp_no_config (from PROJECT) excludes [cpp_config]
cpp_root (from PROJECT) excludes [cpp_no_root]
cpp_cleanup (from PROJECT) excludes [cpp_no_cleanup]
cpp_scripts (from PROJECT) excludes [cpp_no_scripts]
cpp_prototypes (from PROJECT) excludes [cpp_no_prototypes]
cpp_with_installarea (from PROJECT) excludes [cpp_without_installarea]
cpp_without_version_directory (from PROJECT) excludes [cpp_with_version_directory]
cpp (from PROJECT)
sniper_no_config (from PROJECT) excludes [sniper_config]
sniper_root (from PROJECT) excludes [sniper_no_root]
sniper_cleanup (from PROJECT) excludes [sniper_no_cleanup]
sniper_scripts (from PROJECT) excludes [sniper_no_scripts]
sniper_prototypes (from PROJECT) excludes [sniper_no_prototypes]
sniper_with_installarea (from PROJECT) excludes [sniper_without_installarea]
sniper_without_version_directory (from PROJECT) excludes [sniper_with_version_directory]
ExternalInterface_no_config (from PROJECT) excludes [ExternalInterface_config]
ExternalInterface_no_root (from PROJECT) excludes [ExternalInterface_root]
ExternalInterface_cleanup (from PROJECT) excludes [ExternalInterface_no_cleanup]
ExternalInterface_scripts (from PROJECT) excludes [ExternalInterface_no_scripts]
ExternalInterface_prototypes (from PROJECT) excludes [ExternalInterface_no_prototypes]
ExternalInterface_without_installarea (from PROJECT) excludes [ExternalInterface_with_installarea]
ExternalInterface_without_version_directory (from PROJECT) excludes [ExternalInterface_with_version_directory]
x86_64 (from package CMT)
debianjessie/sid (from package CMT)
gcc482 (from package CMT)
Unix (from package CMT) excludes [WIN32 Win32]
----------> CMTPATH
# Add path /home/liujy/mongo-client/MirguestIssueReport/Prog/cpp/DatabaseProject from initialization
# Add path /home/liujy/juno/sniper from initialization
# Add path /home/liujy/juno/ExternalInterface from ProjectPath
