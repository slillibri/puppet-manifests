class ssh{
  package{'sshd':
    ensure => 'running',
    require => Package['openssh-server'],
    subscribe => File['sshd_config']}
  
  file{'sshd_config':
    name => '/etc/ssh/sshd_config',
    owner => 'root',
    group => 'root',
    mode => '644',
    source => 'puppet:///sshd/sshd_config',
    require => Package['openssh-server']}
}