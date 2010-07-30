class nrpe{
  package{'nagios-nrpe-server':
    ensure => 'installed'}
  
  service{'nagios-nrpe-server':
    ensure => 'running',
    require => Package['nagios-nrpe-server']}
  
  @@nagios_service{"check_load_$hostname":
    target => "/etc/nagios3/conf.d/$hostname.cfg",
    check_command => 'check_nrpe_1arg!check_load',
    use => 'generic-service',
    service_description => 'Load',
    host_name => "$fqdn"}

  @@nagios_service{"check_disk_$hostname":
    target => "/etc/nagios3/conf.d/$hostname.cfg",
    check_command => 'check_nrpe_1arg!check_disk',
    use => 'generic-service',
    service_description => 'Disk Usage',
    host_name => "$fqdn"}

  @@nagios_service{"check_memory_$hostname":
    target => "/etc/nagios3/conf.d/$hostname.cfg",
    check_command => 'check_nrpe_1arg!check_memory',
    use => 'generic-service',
    service_description => 'Check Memory',
    host_name => "$fqdn"}
}