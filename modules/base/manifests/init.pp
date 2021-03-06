class base{
  include sudo
  include rsync
  include users
  include sshd
  include hostname
  include logwatch
  include fail2ban
  
  package{'telnet': ensure => 'installed'}

  case $operatingsystem {
    debian: {include base::debian}
    centos: {include base::centos}
    default: {warning("No operating system: $operatingsystem defined")}
  }
  
  class debian{
    include development

    file{'lsconfig':
      path => '/usr/local/bin/lsconfig',
      owner => 'root',
      group => 'root',
      mode => 555,
      ensure => 'present',
      source => 'puppet:///modules/base/lsconfig'}
    
    file{'apt-sources':
      path => '/etc/apt/sources.list',
      owner => 'root',
      group => 'root',
      mode => '644',
      ensure => 'present',
      source => 'puppet:///modules/base/apt-sources'}
  
    exec{'update':
      command => '/usr/bin/apt-get update',
      subscribe => File['apt-sources'],
      refreshonly => true}
  }
  
  class centos{}
}