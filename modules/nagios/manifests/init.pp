class nagios {
  package{'nagios3':
    ensure => 'installed'}
      
  service{'nagios3':
    ensure => running,
    alias  => 'nagios',
    hasstatus => true,
    hasrestart => true,
    require => Package['nagios3']}
    
  
  Nagios_host <<||>>
  Nagios_service <<||>>
  Nagios_hostextinfo <<||>>
  
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
      target => '/etc/nagios3/nagios_service.cfg',
      host_name => "$fqdn"}
  }
}