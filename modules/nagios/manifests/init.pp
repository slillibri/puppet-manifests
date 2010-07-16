class nagios {
  package{'nagios3':
    ensure => 'installed'}
      
  service{'nagios3':
    ensure => running,
    alias  => 'nagios',
    hasstatus => true,
    hasrestart => true,
    require => Package['nagios3'],
    subscribe => [File['nagios.cfg'],Class['target']]}
  
  
  file{'nagios.cfg':
    path  => '/etc/nagios3/nagios.cfg',
    owner => 'root', group => 'root', mode => 644,
    source => 'puppet:///modules/nagios/nagios.cfg'}
  
  file{"$hostname.cfg":
    path => "/etc/nagios3/conf.d/$hostname.cfg",
    owner => 'root', group => 'root', mode => 644}
  
  Nagios_host <<||>>
  Nagios_service <<||>>
  Nagios_hostextinfo <<||>>
  Nagios_command <<||>>
  
  class target {
    @@nagios_host{$fqdn:
      ensure => 'present',
      alias => $hostname,
      address => $ipaddress,
      target => '/etc/nagios3/nagios_host.cfg',
      use => 'generic-host'}
    
    @@nagios_hostextinfo {$fqdn:
      ensure => present,
      icon_image_alt => $operatingsystem,
      icon_image => "base/$operatingsystem.png",
      target => '/etc/nagios3/nagios_hostextinfo.cfg',
      statusmap_image => "base/$operatingsystem.gd2"}
      
    @@nagios_service{"check_ping_$hostname":
      check_command => 'check_ping',
      use => 'generic-service',
      target => "/etc/nagios3/conf.d/$hostname.cfg",
      host_name => "$fqdn"}    
  }
}