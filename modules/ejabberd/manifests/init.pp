class ejabberd {
  package{'ejabberd':
    ensure => 'installed'}
  
  service{'ejabberd':
    ensure => 'running',
    require => Package['ejabberd'],
    subscribe => File['ejabberd.cfg']}
  
  file{'ejabberd.cfg':
    path => '/etc/ejabberd/ejabberd.cfg',
    owner => 'root', group => 'root', mode => 600,
    content => template('ejabberd.erb'),
    require => Service['ejabberd']}
  
  file{'jabber':
    path => '/etc/nagios-plugins/config/jabber.cfg',
    owner => 'root', group => 'root', mode => '644',
    source => "puppet:///modules/ejabberd/jabber"}
  
  @@nagios_service{'check_ejabberd':
    target => "/etc/nagios3/conf.d/$hostname.cfg",
    check_command => 'check_jabber',
    use => 'generic-service',
    service_description => 'EJabberd',
    host_name => "$fqdn"}
}