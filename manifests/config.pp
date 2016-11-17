class dovecot::config inherits dovecot {

  concat { '/etc/dovecot/dovecot.conf':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  concat::fragment{ '/etc/dovecot/dovecot.conf base':
    target  => '/etc/dovecot/dovecot.conf',
    order   => '00',
    content => template("${module_name}/dovecotconf.erb"),
  }

}
