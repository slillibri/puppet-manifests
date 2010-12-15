class ruby-shadow{
  package{'ruby-shadow':
    name => $operatingsystem ? {
      debian => 'libshadow-ruby1.8',
      centos => 'ruby-shadow'
    },
    ensure => 'installed'}
}

class users{
  include ruby-shadow
  include sudo
  
  user{'scott':
    comment => 'Scott Lillibridge',
    home => '/home/scott',
    shell => '/bin/bash',
    groups => $operatingsystem ? {
      debian => ['adm','sudo','users'],
      centos => ['adm','wheel','users']
    },
    password => '$6$KNG1E0RL$yvOlUhO5jG10KIzA3yYiUFeX346peyLwEJCAdqvOiMK6HVM9K/dShG7ySgZ2d3TymRpGT7kqMTAHZv.WejfNQ.'}
  
  file{'/home/scott':
    ensure => 'directory',
    require => User['scott'],
    owner => 'scott',
    group  => 'scott'}
  
  file{'/home/scott/.ssh':
    ensure => 'directory',
    require => File['/home/scott']}
  
  file{'/home/scott/.ssh/authorized_keys':
    owner => 'scott',
    group => 'scott',
    mode => '600',
    source => 'puppet:///modules/users/scott_keys',
    require => File['/home/scott/.ssh']}
}