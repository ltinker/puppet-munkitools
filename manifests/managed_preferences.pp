# Class: munkitools::preferences
#
# This module manages munki ManagedInstalls.plist
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class munkitools::managed_preferences (
  $managedInstallsPath                         = "/Library/Preferences", # /ManagedInstalls.plist
  $secureManagedInstallPath                    = "/private/var/root/Library/Preferences",
  $managedInstallDir                           = '/Library/Managed Installs', # string
  $logsDir                                     = "${managedInstallDir}/Logs",
  $certsDir                                    = "${managedInstallDir}/certs",
  $useSecureManagedInstalls                    = false,
  ####Managed Preference Values####
  $appleSoftwareUpdatesOnly                    = false, # boolean
  $installAppleSoftwareUpdates                 = false, # boolean
  $unattendedAppleUpdates                      = false, # boolean
  $softwareUpdateServerURL                     = none, # string
  $softwareUpdateServerURLManage               = false, # boolean
  $softwareRepoURL                             = none, #string
  $packageURL                                  = "${softwareRepoURL}/pkgs", # string
  $catalogURL                                  = "${softwareRepoURL}/catalogs", # string
  $manifestURL                                 = "${softwareRepoURL}/manifests", #string
  $iconURL                                     = "${softwareRepoURL}/icons", #string
  $clientResourceURL                           = "${softwareRepoURL}/client_resources", # string
  $clientResourceFilename                      = "site_default.zip", # string
  $helpURL                                     = none, # string
  $clientIdentifier                            = none, # string
  $logFile                                     = "${logsDir}/ManagedSoftwareUpdate", #string
  $logToSyslog                                 = false, #boolean
  $loggingLevel                                = 1, #integer
  $daysBetweenNotifications                    = 1, #integer
  $useClientCertificate                        = false, #boolean
  $useClientCertificateCNAsClientIdentifier    = false, #boolean
  $softwareRepoCAPath                          = "", # string
  $softwareRepoCAPathCertificate               = "${certsDir}/ca.pem", # string
  $clientCertificatePath                       = "${certsDir}/clientcert.pem", # string
  $clientKeyPath                               = "", # string
  $additionalHttpHeaders                       = "", # array
  $packageVerificationMode                     = "hash", # string
  $supressUserNotification                     = false, # boolean
  $supressAutoInstall                          = false, # boolean
  $supressLoginwindowInstall                   = false, # boolean
  $supressStopButtonOnInstall                  = false, # boolean
  $installRequiresLogout                       = false, # boolean
  $showRemovalDetail                           = false, # boolean
  $mSULogEnabled                               = false, # boolean
  $mSUDebugLogEnabled                          = false, # boolean
  $localOnlyManifest                           = "", # string
  $followHTTPRedirects                         = "", # string
  $ignoreSystemProxies                         = false, # boolean
  ######
  $user                                        = 'root',
  $group                                       = 'wheel',
  $preferenceFile                              = "${managedInstallsPath}/ManagedInstalls.plist",

  ){
  file {
    [$managedInstallDir]:
      ensure => 'directory',
      owner  => $user,
      group  => $group,
      mode   => '0755';

    $logsDir:
      ensure => 'directory',
      owner  => $user,
      group  => $group,
      mode   => '0755';

    $certsDir:
      ensure  => 'directory',
      owner   => $user,
      group   => $group,
      mode    => '0755';

    "${managedInstallsPath}/ManagedInstalls.plist":
      ensure  => 'present',
      owner   => $user,
      group   => $group,
      mode    => '0755';
  }

  case $useSecureManagedInstalls {
    true: {
      $preferenceDirectory = $secureManagedInstallPath
    }
    default: {
      $preferenceDirectory = $managedInstallsPath
    }
  }


  if $useSecureManagedInstalls{

    file {
      ["${secureManagedInstallPath}/ManagedInstalls.plist"]:
        ensure  => 'present',
        owner   => $user,
        group   => $group,
        mode    => '0700';
    }
  }
  unless $useSecureManagedInstalls{

    file {
      ["${secureManagedInstallPath}/ManagedInstalls.plist"]:
        ensure  => 'absent',
    }

    }

    mac_plist_value {"${managedInstallsPath}/ManagedInstalls.plist:AppleSoftwareUpdatesOnly":
      value => $appleSoftwareUpdatesOnly,
    }
    mac_plist_value {"${managedInstallsPath}/ManagedInstalls.plist:ManagedInstallDir":
      value => $managedInstallDir,
    }
    mac_plist_value {"${managedInstallsPath}/ManagedInstalls.plist:InstallAppleSoftwareUpdates":
      value => $installAppleSoftwareUpdates,
    }
    mac_plist_value {"${managedInstallsPath}/ManagedInstalls.plist:ShowRemovalDetail":
      value => $showRemovalDetail,
    }
    mac_plist_value {"${managedInstallsPath}/ManagedInstalls.plist:InstallRequiresLogout":
      value => $installRequiresLogout,
    }
    mac_plist_value {"${managedInstallsPath}/ManagedInstalls.plist:HelpURL":
      value => $helpURL,
    }
    # Securable Preferences
    mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:UnattendedAppleUpdates":
      value => $unattendedAppleUpdates,
    }
    if $softwareUpdateServerURLManage {
      mac_plist_value {"/Library/Preferences/com.apple.SoftwareUpdate:CatalogURL":
        value => $softwareUpdateServerURL,
      }
    }

    mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:SoftwareRepoURL":
      value => $softwareRepoURL,
    }
    mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:PackageURL":
      value => $packageURL,
    }
    mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:CatalogURL":
      value => $catalogURL,
    }
    mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:ManifestURL":
      value => $manifestURL,
    }
    mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:IconURL":
      value => $iconURL,
    }
    mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:ClientResourceFilename":
      value => $clientResourceFilename,
    }
    mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:ClientIdentifier":
      value => $clientIdentifier,
    }
    mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:LogFile":
      value => $logFile,
    }
    mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:LogToSyslog":
      value => $logToSyslog,
    }
    mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:LoggingLevel":
      value => $loggingLevel,
    }
    mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:DaysBetweenNotifications":
      value => $daysBetweenNotifications,
    }
    mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:UseClientCertificate":
      value => $useClientCertificate,
    }
    mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:UseClientCertificateCNAsClientIdentifier":
      value => $useClientCertificateCNAsClientIdentifier,
    }
    mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:SoftwareRepoCAPath":
      value => $softwareRepoCAPath,
    }
    mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:SoftwareRepoCACertificate":
      value => $softwareRepoCAPathCertificate,
    }
    mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:ClientCertificatePath":
      value => $clientCertificatePath,
    }
    mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:AdditionalHttpHeaders":
      value => $additionalHttpHeaders,
    }
    mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:PackageVerificationMode":
      value => $packageVerificationMode,
    }
    mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:SuppressUserNotification":
      value => $supressUserNotification,
    }
    mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:SuppressAutoInstall":
      value => $supressAutoInstall,
    }
    mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:SuppressLoginwindowInstall":
      value => $supressLoginwindowInstall,
    }
    mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:SuppressStopButtonOnInstall":
      value => $supressStopButtonOnInstall,
    }
    mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:MSULogEnabled":
      value => $mSULogEnabled,
    }
    mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:MSUDebugLogEnabled":
      value => $mSUDebugLogEnabled,
    }
    mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:LocalOnlyManifest":
      value => $localOnlyManifest,
    }
    mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:FollowHTTPRedirects":
      value => $followHTTPRedirects,
    }
    mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:IgnoreSystemProxies":
      value => $ignoreSystemProxies,
    }

#  $preferences.each |String $resource, Hash $attributes| {
#    Resources["mac_plist_value"] {
#      file => "${managedInstallsPath}/ManagedInstalls.plist";
#      key => $resource;
#      value => $attributes;
#    }
#  }

}
# following directories are managed
# /Library/ManagedInstalls $managedInstallDir
# /Library/Managed Installs/Logs $logsDir
# /Library/Managed Installs/certs $certsDir

# Already Exists by Default on OSX /private/var/root/Library/Prefereces/
#

# following files are managed
# /Library/Preferences/ManagedInstalls.plist
# /private/var/root/Library/Preferences/ManagedInstalls.plist
# ${certsDir}/cert.pem
# ${certsDir}/ca.pem

# Structure
# if useSecureManageInstalls = True
# all variables except ManagedInstallDir, InstallAppleSoftwareUpdates, AppleUpdatesOnly, ShowRemovalDetail, InstallRequiresLogout and HelpURL are written to secureManagedInstallPath
