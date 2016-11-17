# userdb {
#     driver = static
#     args = uid=2222 gid=2222 home=/var/vmail/%d/%n allow_all_users=yes
# }
class dovecot::userdb(
                        $driver          = 'static',
                        #static
                        $uid             = $dovecot::params::postfix_username_uid_default,
                        $gid             = $dovecot::params::postfix_username_gid_default,
                        $home            = '/var/vmail/%d/%n',
                        $allow_all_users = true,
                      ) inherits dovecot::params {

  concat::fragment{ '/etc/dovecot/dovecot.conf userdb':
    target  => '/etc/dovecot/dovecot.conf',
    order   => '20',
    content => template("${module_name}/userdb/${driver}.erb"),
  }
}
