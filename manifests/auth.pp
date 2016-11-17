class dovecot::auth(
                      $user = 'root',
                    ) inherits dovecot::params {

  concat::fragment{ '/etc/dovecot/dovecot.conf auth ini':
    target  => '/etc/dovecot/dovecot.conf',
    order   => '30',
    content => template("${module_name}/auth/auth.erb"),
  }

  concat::fragment{ '/etc/dovecot/dovecot.conf auth end':
    target  => '/etc/dovecot/dovecot.conf',
    order   => '39',
    content => "\n}\n",
  }
}
