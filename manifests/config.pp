class dovecot::config inherits dovecot {

  concat { '/etc/dovecot/dovecot.conf':
    ensure => 'present',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  concat::fragment{ '/etc/dovecot/dovecot.conf base':
    target  => '/etc/dovecot/dovecot.conf',
    order   => '00',
    content => template("${module_name}/dovecotconf.erb"),
  }

  concat::fragment{ '/etc/dovecot/dovecot.conf imap opts':
    target  => '/etc/dovecot/dovecot.conf',
    order   => '01',
    content => template("${module_name}/imap/imap_opts.erb"),
  }

  concat::fragment{ '/etc/dovecot/dovecot.conf includes':
    target  => '/etc/dovecot/dovecot.conf',
    order   => '02',
    content => template("${module_name}/includes.erb"),
  }

  # [Definition]
  # failregex = (?: pop3-login|imap-login): (?:Authentication failure|Aborted login \(auth failed|Aborted login \(tried to use disabled|Disconnected \(auth failed).*rip=(?P<host>\S*),.*
  # ignoreregex =


}
