#
# dovecot concat
# 00 - base
# 01 - imap options
# 10 - passdb
# 20 - userdb
# 30 - auth
# 31 - auth - unixlistener
# 39 - end auth
# 40 - imap login
#
class dovecot(
                $manage_package                    = true,
                $package_ensure                    = 'installed',
                $manage_service                    = true,
                $manage_docker_service             = true,
                $service_ensure                    = 'running',
                $service_enable                    = true,
                $listen                            = [ '*' ],
                $login_greeting                    = 'ready to rock',
                $verbose_proctitle                 = true,
                $shutdown_clients                  = true,
                $protocols                         = [ 'imap', 'lmtp' ],
                $disable_plaintext_auth            = false,
                $auth_mechanisms                   = [ 'plain', 'login' ],
                $mail_access_groups                = 'postfix',
                $default_login_user                = 'postfix',
                $first_valid_uid                   = $dovecot::params::postfix_username_uid_default,
                $first_valid_gid                   = $dovecot::params::postfix_username_gid_default,
                $mail_location                     = 'maildir:/var/vmail/%d/%n',
                $ssl                               = false,
                $base_dir                          = '/var/run/dovecot/',
                $imap_idle_notify_interval_minutes = '2',
              ) inherits dovecot::params{

  validate_re($package_ensure, [ '^present$', '^installed$', '^absent$', '^purged$', '^held$', '^latest$' ], 'Not a supported package_ensure: present/absent/purged/held/latest')
  validate_array($listen)

  class { '::dovecot::install': }
  -> class { '::dovecot::config': }
  ~> class { '::dovecot::service': }
  -> Class['::dovecot']

}
