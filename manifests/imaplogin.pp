# service imap-login {
#   process_min_avail = 1
#   user = postfix
# }
class dovecot::imaplogin(
                          $process_min_avail = '1',
                          $user              = 'postfix',
                        ) inherits dovecot::params {

  concat::fragment{ '/etc/dovecot/dovecot.conf imaplogin':
    target  => '/etc/dovecot/dovecot.conf',
    order   => '40',
    content => template("${module_name}/imaplogin/imaplogin.erb"),
  }

  concat::fragment{ '/etc/dovecot/dovecot.conf imap opts':
    target  => '/etc/dovecot/dovecot.conf',
    order   => '01',
    content => template("${module_name}/imap/imap_opts.erb"),
  }
}
