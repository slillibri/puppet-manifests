class ruby-shadow{
  package{'ruby-shadow':
    name => 'libshadow-ruby1.8',
    ensure => 'installed'}
}

class users{
  include ruby-shadow
  
  user{'scott':
    comment => 'Scott Lillibridge',
    home => '/home/scott',
    shell => '/bin/bash',
    groups => ['dialout','cdrom','floppy','audio','video','plugdev','adm','sudo'],
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