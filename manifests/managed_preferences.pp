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
  $softwareUpdateServerURL                     = undef, # string
  $softwareRepoURL                             = undef, # string
  $packageURL                                  = undef, # string, Defaults to "${softwareRepoURL}/pkgs"
  $catalogURL                                  = undef, # string, Defaults to "${softwareRepoURL}/catalogs"
  $manifestURL                                 = undef, # string, Defaults to "${softwareRepoURL}/manifests"
  $iconURL                                     = undef, # string, Defaults to "${softwareRepoURL}/icons"
  $clientResourceURL                           = undef, # string, Defaults to "${softwareRepoURL}/client_resources"
  $clientResourceFilename                      = undef, # string, Defaults to $clientIdentifier then "site_default.zip"
  $helpURL                                     = undef, # string
  $clientIdentifier                            = undef, # string
  $logFile                                     = undef, # string, Defaults to "${logsDir}/ManagedSoftwareUpdate"
  $logToSyslog                                 = false, # boolean
  $loggingLevel                                = 1, # integer
  $daysBetweenNotifications                    = 1, # integer
  $useClientCertificate                        = false, # boolean
  $useClientCertificateCNAsClientIdentifier    = false, # boolean
  $softwareRepoCAPath                          = undef, # string
  $softwareRepoCAPathCertificate               = undef, # string, Defaults to "${certsDir}/ca.pem"
  $clientCertificatePath                       = undef, # string, Defaults to "${certsDir}/clientcert.pem"
  $clientKeyPath                               = undef, # string
  $additionalHttpHeaders                       = undef, # array
  $packageVerificationMode                     = "hash", # string
  $supressUserNotification                     = false, # boolean
  $supressAutoInstall                          = false, # boolean
  $supressLoginwindowInstall                   = false, # boolean
  $supressStopButtonOnInstall                  = false, # boolean
  $installRequiresLogout                       = false, # boolean
  $showRemovalDetail                           = false, # boolean
  $mSULogEnabled                               = false, # boolean
  $mSUDebugLogEnabled                          = false, # boolean
  $localOnlyManifest                           = undef, # string
  $followHTTPRedirects                         = undef, # string
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
    # if $softwareUpdateServerURL {
      # mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:SoftwareUpdateServerURL":
        # value => $softwareUpdateServerURL,
      # }
    # }
    # unless $softwareUpdateServerURL {
      mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:SoftwareUpdateServerURL":
        ensure => absent,
      }
    # }
    if $softwareRepoURL {
      mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:SoftwareRepoURL":
        value => $softwareRepoURL,
      }
    }
    unless $softwareRepoURL {
      mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:SoftwareRepoURL":
        ensure => absent,
      }
    }
    if $packageURL {
      mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:PackageURL":
        value => $packageURL,
      }
    }
    unless $packageURL {
      mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:PackageURL":
        ensure => absent,
      }
    }
    if $catalogURL {
      mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:CatalogURL":
        value => $catalogURL,
      }
    }
    unless $catalogURL {
      mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:CatalogURL":
        ensure => absent,
      }
    }
    if $manifestURL {
      mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:ManifestURL":
        value => $manifestURL,
      }
    }
    unless $manifestURL {
      mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:ManifestURL":
        ensure => absent,
      }
    }
    if $iconURL {
      mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:IconURL":
        value => $iconURL,
        }
    }
    unless $iconURL{
      mac_plist_value {"${preferenceDirectory}/ManagedInstalls.plist:IconURL":
        ensure => absent,
      }
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
