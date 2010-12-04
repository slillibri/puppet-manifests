class ejabberd {
  package{'ejabberd':
    ensure => 'installed'}
  
  service{'ejabberd':
    ensure => 'running',
    require => Package['ejabberd']}
    
  @@nagios_service{'check_ejabberd':
    target => '/etc/nagios3/conf.d/hostname.cfg',
    check_command => 'check_jabber',
    use => 'generic_service',
    service_description => 'EJabberd',
    host_name => "$fqdn"}
}