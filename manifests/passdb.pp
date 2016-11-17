# passdb {
#     driver = passwd-file
#     args = scheme=SHA1 /etc/dovecot/passwd
# }
class dovecot::passdb(
                        $driver     = 'passwd-file',
                        #passwd-file
                        $scheme     = 'SHA1',
                        $passwdfile = '/etc/dovecot/passwd',
                      ) inherits dovecot::params {

  concat::fragment{ '/etc/dovecot/dovecot.conf passdb':
    target  => '/etc/dovecot/dovecot.conf',
    order   => '10',
    content => template("${module_name}/passdb/${driver}.erb"),
  }
}
