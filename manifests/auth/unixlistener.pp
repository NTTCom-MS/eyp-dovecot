#
# unix_listener auth-client {
#     group = postfix
#     mode = 0660
#     user = postfix
# }
class dovecot::auth::unixlistener(
                                    $user  = 'postfix',
                                    $group = 'postfix',
                                    $mode  = '0660',
  ) inherits dovecot::params {

  concat::fragment{ '/etc/dovecot/dovecot.conf auth unixlistener':
    target  => '/etc/dovecot/dovecot.conf',
    order   => '31',
    content => template("${module_name}/auth/unixlistener.erb"),
  }

}
