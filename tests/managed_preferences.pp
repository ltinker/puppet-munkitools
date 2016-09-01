class{ '::munkitools::managed_preferences':
  softwareUpdateServerURL => "http://",
  softwareRepoURL         => "http://munki/repo",
  clientIdentifier        =>  "${hostname}",
  useSecureManagedInstalls =>  true,
}