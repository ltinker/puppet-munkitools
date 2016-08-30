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
Class munkitools::managed_installs (
  $appleSoftwareUpdatesOnly                    = $::munkitools::params::appleSoftwareUpdatesOnly, # boolean
  $installAppleSoftwareUpdates                 = $::munkitools::params::installAppleSoftwareUpdates, # boolean
  $unattendedAppleUpdates                      = $::munkitools::params::unattendedAppleUpdates, # boolean
  $softwareUpdateServerURL                     = $::munkitools::params::softwareUpdateServerURL, # string
  $softwareRepoURL                             = $::munkitools::params::softwareRepoURL, #string
  $packageURL                                  = $::munkitools::params::packageURL, # string
  $catalogURL                                  = $::munkitools::params::catalogURL, # string
  $manifestURL                                 = $::munkitools::params::manifestURL, #string
  $iconURL                                     = $::munkitools::params::iconURL, #string
  $clientResourceURL                           = $::munkitools::params::clientResourceURL, # string
  $clientResourceFilename                      = $::munkitools::params::clientResourceFilename, # string
  $helpURL                                     = $::munkitools::params::helpURL, # string
  $clientIdentifier                            = $::munkitools::params::clientIdentifier, # string
  $managedInstallDir                           = $::munkitools::params::managedInstallDir, # string
  $logFile                                     = $::munkitools::params::logFile, #string
  $logToSyslog                                 = $::munkitools::params::logToSyslog, #boolean
  $loggingLevel                                = $::munkitools::params::loggingLevel, #integer
  $daysBetweenNotifications                    = $::munkitools::params::daysBetweenNotifications, #integer
  $useClientCertificate                        = $::munkitools::params::useClientCertificate, #boolean
  $useClientCertificateCNAsClientIdentifier    = $::munkitools::params::useClientCertificateCNAsClientIdentifier, #boolean
  $softwareRepoCAPath                          = $::munkitools::params::softwareRepoCAPath, # string
  $softwareRepoCAPathCertificate               = $::munkitools::params::softwwareRepoCAPathCertificate, # string
  $clientCertificatePath                       = $::munkitools::params::clientCertificatePath, # string
  $clientKeyPath                               = $::munkitools::params::clientKeyPath, # string
  $additionalHttpHeaders                       = $::munkitools::params::additionalHttpHeaders, # array
  $packageVerificationMode                     = $::munkitools::params::packageVerificationMode, # string
  $supressUserNotification                     = $::munkitools::params::suppressUserNotification, # boolean
  $supressAutoInstall                          = $::munkitools::params::supressAutoInstall, # boolean
  $supressLoginwindowInstall                   = $::munkitools::params::supressLoginwindowInstall, # boolean
  $supressStopButtonOnInstall                  = $::munkitools::params::supressStopButtonOnInstall, # boolean
  $installRequiresLogout                       = $::munkitools::params::installRequiresLogout, # boolean
  $showRemovalDetail                           = $::munkitools::params::showRemovalDetail, # boolean
  $mSULogEnabled                               = $::munkitools::params::mSULogEnabled, # boolean
  $mSUDebugLogEnabled                          = $::munkitools::params::mSUDebugLogEnabled, # boolean
  $localOnlyManifest                           = $::munkitools::params::localOnlyManifest, # string
  $followHTTPRedirects                         = $::munkitools::params::followHTTPRedirects, # string
  $ignoreSystemProxies                         = $::munkitools::params::ignoreSystemProxies # string
)