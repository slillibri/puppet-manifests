class ejabberd {
  package{'ejabberd':
    ensure => 'installed'}
  
  service{'ejabberd':
    ensure => 'running',
    require => Package['ejabberd']}
  
  file{'jabber':
    path => '/etc/nagios-plugns/config/jabber',
    owner => 'root', group => 'root', mode => '644',
    source => "puppet://modules/ejabberd/jabber"}
  
  @@nagios_service{'check_ejabberd':
    target => "/etc/nagios3/conf.d/$hostname.cfg",
    check_command => 'check_jabber',
    use => 'generic-service',
    service_description => 'EJabberd',
    host_name => "$fqdn"}
}