class nagios {
  package{'nagios3':
    ensure => 'installed'}
      
  service{'nagios3':
    ensure => running,
    alias  => 'nagios',
    hasstatus => true,
    hasrestart => true,
    require => Package['nagios3'],
    subscribe => File['nagios.cfg']}
  
  
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
  
  @@nagios_command{"check_web_auth":
    target => '/etc/nagios3/nagios_commands.cfg',
    command_line => '/usr/lib/nagios/plugins/check_http -H $HOSTNAME$ -a $ARG1$',
    command_name => 'check_web_auth'}
    
  file{'localhost_nagios2.cfg':
    path => '/etc/nagios3/conf.d/localhost_nagios2.cfg',
    ensure => 'absent'}      
  file{'hostgroups_nagios2.cfg':
    path => '/etc/nagios3/conf.d/hostgroups_nagios2.cfg',
    ensure => 'absent'}
  file{'services_nagios2.cfg':
    path => '/etc/nagios3/conf.d/services_nagios2.cfg',
    ensure => 'absent'}
  
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