class munkitools::install_agent (
  $override_version = False,
  $version = '2.8.1.2835',
) inherits ::munkitools::params{
 
   case $override_version  {
    true: {
      $source = "https://munkibuilds.org/${version}/munkitools-${version}.pkg"
    }
    default: {
      $source = "https://munkibuilds.org/munkitools2-latest.pkg"
    }
  }
 
   package { "munkitools":
    ensure   => installed,
    provider => pkgdmg,
    source   => $source,
  }
  
}
