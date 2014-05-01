## Installs and configures redis from epel
class redis(
  $package_name  = 'UNSET',
  $enable_epel   = true,
  $template_path = 'redis/redis.conf.erb'
) {

  case $::osfamily {
    'RedHat': {
      $os_package_name = 'redis'
      $service_name    = 'redis'
      $redis_conf_path = '/etc/redis.conf'

      if $enable_epel {
        include epel
        Class['epel'] -> Package['redis']
      }
    }
    'Debian': {
      $os_package_name = 'redis-server'
      $service_name    = 'redis-server'
      $redis_conf_path = '/etc/redis/redis.conf'
    }
    default: {
      fail("Operating system '${::operatingsystem}' not supported")
    }
  }

  if $package_name == 'UNSET' {
    $package_name_real = $os_package_name
  } else {
    $package_name_real = $package_name
  }

  package { 'redis':
    ensure => installed,
    name   => $package_name_real,
  }

  file { 'redis.conf':
    ensure  => file,
    path    => $redis_conf_path,
    content => template($template_path),
  }

  service { 'redis':
    ensure => running,
    enable => true,
    name   => $service_name,
  }

  # relationships
  Package['redis']   -> File['redis.conf']
  File['redis.conf'] ~> Service['redis']

}
