class dovecot::install inherits dovecot {

  if($dovecot::manage_package)
  {
    package { $dovecot::params::package_name:
      ensure => $dovecot::package_ensure,
    }

    exec { "mkdir eyp-dovecot ${dovecot::base_dir}":
      command => "mkdir -p ${dovecot::base_dir}",
      creates => $dovecot::base_dir,
      require => Package[$dovecot::params::package_name],
    }

    # drwxr-xr-x 5 root dovecot 700 Nov 17 16:47 /var/run/dovecot/
    file { $dovecot::base_dir:
      ensure  => 'directory',
      owner   => 'root',
      group   => 'dovecot',
      mode    => '0755',
      require => Exec["mkdir eyp-dovecot ${dovecot::base_dir}"],
    }
  }

}
