class { 'dovecot':
  default_login_user => 'dovecot',
  mail_access_groups => 'dovecot',
}

class { 'dovecot::userdb': }
class { 'dovecot::passdb': }
class { 'dovecot::auth': }

class { 'dovecot::auth::unixlistener':
  user   => 'dovecot',
  group  => 'dovecot',
}
class { 'dovecot::imaplogin':
  user => 'dovecot',
}

dovecot::account { 'jordi@prats.cat':
  password => 'demopassw0rd',
}
