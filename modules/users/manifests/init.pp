class users{
  user{'scott':
    comment => 'Scott Lillibridge',
    home => '/home/scott',
    shell => '/bin/bash',
    groups => ['dialout','cdrom','floppy','audio','video','plugdev','adm','sudo']}
  
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