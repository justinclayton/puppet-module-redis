## Installs and configures redis

class redis(
  $package_name  = undef,
  $enable_epel   = true,
  $template_path = 'redis/redis.conf.erb',
  $scl           = false,
) {

  case $::osfamily {
    'RedHat': {
      if $scl {
        $os_package_name = 'rh-redis32'
        $service_name    = 'rh-redis32-redis'
        $redis_conf_path = '/etc/opt/rh/rh-redis32/redis.conf'
        }
      else {
        $os_package_name = 'redis'
        $service_name    = 'redis'
        $redis_conf_path = '/etc/redis.conf'
        }

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

  if $package_name == undef {
    $package_name_real = $os_package_name
  } else {
    $package_name_real = $package_name
  }

  package { $package_name_real:
    ensure => installed,
  }

  file { 'redis.conf':
    ensure  => file,
    path    => $redis_conf_path,
    content => template($template_path),
  }

  service { $service_name:
    ensure => running,
    enable => true,
  }

  # relationships
  Package[$package_name_real]   -> File['redis.conf']
  File['redis.conf'] ~> Service[$service_name]

}
