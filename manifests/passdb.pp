# passdb {
#     driver = passwd-file
#     args = scheme=SHA1 /etc/dovecot/passwd
# }
class dovecot::passdb(
                        $driver     = 'passwd-file',
                        #passwd-file
                        $scheme     = 'SHA1',
                        $passwdfile = $dovecot::params::passwdfile_default,
                      ) inherits dovecot::params {
  include ::dovecot

  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  concat::fragment{ '/etc/dovecot/dovecot.conf passdb':
    target  => '/etc/dovecot/dovecot.conf',
    order   => '10',
    content => template("${module_name}/passdb/${driver}.erb"),
  }

  $dirname_passwdfile=dirname($passwdfile)

  exec { "passwd eyp-dovecot dirname ${passwdfile}":
    command => "mkdir -p ${dirname_passwdfile}",
    creates => $dirname_passwdfile,
  }

  file { $passwdfile:
    ensure => 'present',
    owner  => 'root',
    group  => 'root',
    mode   => '0600',
  }

}
