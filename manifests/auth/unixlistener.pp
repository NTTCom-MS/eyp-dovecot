#
# unix_listener auth-client {
#     group = postfix
#     mode = 0660
#     user = postfix
# }
class dovecot::auth::unixlistener(
                                    $user   = $dovecot::default_login_user,
                                    $group  = $dovecot::mail_access_groups,
                                    $mode   = '0660',
                                    $socket = 'auth-client',
  ) inherits dovecot::params {

  include ::dovecot

  concat::fragment{ '/etc/dovecot/dovecot.conf auth unixlistener':
    target  => '/etc/dovecot/dovecot.conf',
    order   => '31',
    content => template("${module_name}/auth/unixlistener.erb"),
  }

}
