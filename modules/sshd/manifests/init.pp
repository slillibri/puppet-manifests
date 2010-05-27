class sshd{
  service{'ssh': 
    require => Package['openssh-server'],
    ensure => 'running'}
  
  package{'openssh-server':
    ensure => 'installed'}
  
  file{'sshd_config':
    name => '/etc/ssh/sshd_config',
    owner => 'root',
    group => 'root',
    mode => '644',
    source => 'puppet:///sshd/sshd_config',
    notify => Service['ssh']}
}