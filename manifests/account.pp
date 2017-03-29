define dovecot::account (
                          $password,
                          $account = $name,
                          $passwdfile = $dovecot::params::passwdfile_default,
                        ) {
  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  include ::dovecot

  exec { "add passwd-file ${account}":
    command => "bash -c 'echo \"${account}:$(doveadm pw -s sha1 -p ${password} | cut -d '}' -f2)\" >> ${passwdfile}'",
    unless  => "bash -c 'grep \"${account}:$(doveadm pw -s sha1 -p ${password} | cut -d '}' -f2)\" ${passwdfile}'",
    require => Class['dovecot'],
  }
}
