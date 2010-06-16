class base{
  include development
  include sudo
  include rsync
  include users
  include sshd
  include hostname
  include logwatch
  
  package{'fail2ban': ensure => 'installed'}
  package{'telnet': ensure => 'installed'}
  
  file{'lsconfig':
    path => '/usr/local/bin/lsconfig',
    owner => 'root',
    group => 'root',
    mode => 555,
    ensure => 'present',
    source => 'puppet:///base/lsconfig'}
}