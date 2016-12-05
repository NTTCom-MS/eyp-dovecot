class dovecot::params {


  $service_name='dovecot'

  $passwdfile_default = '/etc/dovecot/passwd'

  case $::osfamily
  {
    'redhat':
    {
      $package_name='dovecot'
      case $::operatingsystemrelease
      {
        /^[5-7].*$/:
        {
          $postfix_username_uid_default='89'
          $postfix_username_gid_default='89'
        }
        default: { fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")  }
      }
    }
    'Debian':
    {
      $package_name=[ 'dovecot-core', 'dovecot-imapd' ]
      case $::operatingsystem
      {
        'Ubuntu':
        {
          case $::operatingsystemrelease
          {
            /^14.*$/:
            {
              $postfix_username_uid_default='89'
              $postfix_username_gid_default='89'
            }
            default: { fail("Unsupported Ubuntu version! - ${::operatingsystemrelease}")  }
          }
        }
        'Debian': { fail('Unsupported')  }
        default: { fail('Unsupported Debian flavour!')  }
      }
    }
    default: { fail('Unsupported OS!')  }
  }
}
