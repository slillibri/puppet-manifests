class users{
  user{'scott':
    comment => 'Scott Lillibridge',
    home => '/home/scott',
    shell => '/bin/bash',
    groups => ['scott','dialout','cdrom','floppy','audio','video','plugdev','adm','sudo']}
  
  file{'/home/scott/.ssh':
    ensure => 'directory',
    require => User['scott']}
  
  file{'/home/scott/.ssh/authorized_keys':
    owner => 'scott',
    group => 'scott',
    mode => '600',
    source => 'puppet:///users/scott_keys',
    require => [User['scott'],File['/home/scott/.ssh']]}
}