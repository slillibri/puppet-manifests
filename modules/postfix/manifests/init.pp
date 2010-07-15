class postfix{
  package{'postfix':
    ensure => 'installed'}
  
  service{'postfix':
    require => Package['postfix']}
  
  file{'main.cf':
    owner => 'root',
    group => 'root',
    mode => 644,
    name => '/etc/postfix/main.cf',
    content => template('main.erb'),
    require => Package['postfix'],
    notify => Service['postfix']}
    
  file{'aliases':
    owner => 'root',
    group => 'root',
    mode => 644,
    name => '/etc/aliases',
    source => 'puppet:///modules/postfix/aliases',
    require => Package['postfix'],
    notify => Exec['newaliases']}
  
  exec{'newaliases':
    path => '/bin:/usr/bin',
    subscribe => File['aliases'],
    refreshonly => true}
    
  @@nagios_service{"check_smtp_$fqdn":
    check_command => 'check_smtp',
    use => 'generic-service',
    target => "/etc/nagios3/conf.d/$hostname.cfg",
    service_description => 'SMTP',
    host_name => "$fqdn",
    event_handler => 'restart_postfix'}
  
  @@nagios_command{"restart_postfix":
    target => '/etc/nagios3/nagios_commands.cfg',
    command_line => 'sudo /etc/init.d/postfix restart',
    command_name => 'restart_postfix'}
}