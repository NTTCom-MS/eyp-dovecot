define dovecot::account (
                          $password,
                          $account = $name,
                          $passwdfile = $dovecot::params::passwdfile_default,
                        ) {
  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  exec { "add passwd-file ${account}":
    command => "bash -c 'echo \"${account}:$(doveadm pw -s sha1 -p ${password} | cut -d '}' -f2)\" >> ${passwdfile}'",
    unless => "grep \"${account}:$(doveadm pw -s sha1 -p ${password} | cut -d '}' -f2)\" ${passwdfile}",
  }
}
