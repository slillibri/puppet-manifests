class postfix{
  package{'postfix':
    ensure => 'installed'}
  
  service{'postfix':
    require => Package['postfix'],
    subscribe => File['main.cf']}
  
  file{'main.cf':
    name => '/etc/postfix/main.cf',
    content => template('main.erb'),
    notify => Service['postfix']}
    
  file{'aliases':
    name => '/etc/aliases',
    content => 'puppet:///postfix/aliases',
    notify => Exec['newaliases']}
  
  exec{'newaliases':
    path => '/bin:/usr/bin',
    subscribe => File['aliases'],
    refreshonly => true}
}