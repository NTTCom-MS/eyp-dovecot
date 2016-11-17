class dovecot::service inherits dovecot {

  #
  validate_bool($dovecot::manage_docker_service)
  validate_bool($dovecot::manage_service)
  validate_bool($dovecot::service_enable)

  validate_re($dovecot::service_ensure, [ '^running$', '^stopped$' ], "Not a valid daemon status: ${dovecot::service_ensure}")

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $dovecot::manage_docker_service)
  {
    if($dovecot::manage_service)
    {
      service { $dovecot::params::service_name:
        ensure => $dovecot::service_ensure,
        enable => $dovecot::service_enable,
      }
    }
  }
}
