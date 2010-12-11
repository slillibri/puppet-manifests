class fail2ban {
  package{'fail2ban':
    ensure => 'installed'}
    
  service{'fail2ban':
    require => [Package['fail2ban'],File['jail.conf']]}
    
  file{'jail.conf':
    path => '/etc/fail2ban/jail.conf',
    owner => 'root',
    group => 'root',
    mode => 644,
    require => Package['fail2ban'],
    notify => Service['fail2ban'],
    source => 'puppet:///modules/fail2ban/jail.conf'}
}