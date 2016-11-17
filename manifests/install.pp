class dovecot::install inherits dovecot {

  if($dovecot::manage_package)
  {
    package { $dovecot::params::package_name:
      ensure => $dovecot::package_ensure,
    }
  }

}
