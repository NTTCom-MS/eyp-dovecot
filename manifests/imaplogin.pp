# service imap-login {
#   process_min_avail = 1
#   user = postfix
# }
class dovecot::imaplogin(
                          $process_min_avail = $::processorcount,
                          $user              = $dovecot::default_login_user,
                        ) inherits dovecot::params {
  include ::dovecot

  concat::fragment{ '/etc/dovecot/dovecot.conf imaplogin':
    target  => '/etc/dovecot/dovecot.conf',
    order   => '40',
    content => template("${module_name}/imaplogin/imaplogin.erb"),
  }
}
