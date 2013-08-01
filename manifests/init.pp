## Installs and configures redis from epel
class redis( $enable_epel = false ) {

  case $::osfamily {
    'RedHat': {
      $package_name    = 'redis'
      $service_name    = 'redis'
      $redis_conf_path = '/etc/redis.conf'

      if $enable_epel {
        include epel
        Class['epel'] -> Package['redis']
      }
    }
    'Debian': {
      $package_name    = 'redis-server'
      $service_name    = 'redis-server'
      $redis_conf_path = '/etc/redis/redis.conf'
    }
    default: {
      fail("Operating system '${::operatingsystem}' not supported")
    }
  }

  package { 'redis':
    ensure => installed,
    name   => $package_name,
  }

  file { 'redis.conf':
    ensure  => file,
    path    => $redis_conf_path,
    content => template('redis/redis.conf.erb'),
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