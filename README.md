[![Build Status](https://travis-ci.org/justinclayton/puppet-module-redis.png?branch=master)](https://travis-ci.org/justinclayton/puppet-module-redis)

Description
-------
This module installs a redis server and manages the service, providing a very simple config. It has been tested for RHEL/CentOS as well as Ubuntu using rspec-system.

Installation
------
If you're using librarian-puppet, add a line to your `Puppetfile`:

```
mod 'justinclayton/redis', '1.x'
```

Usage
------
```
include redis
```

If you are using RHEL/CentOS and want to pull the package from somewhere besides EPEL, then use this syntax:

```
class { 'redis':
  enable_epel => false,
}
```

Config options for redis are not exposed to the module. However, you can supply your own ERB template for the config by using this parameter:

```
class { 'redis':
  template_path => 'myownstuff/redis.conf.erb'
}
```