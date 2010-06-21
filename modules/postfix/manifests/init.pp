class postfix{
  package{'postfix':
    ensure => 'installed'}
  
  service{'postfix':
    require => Package['postfix'],
    subscribe => File['main.cf']}
  
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
}