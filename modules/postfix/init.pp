class postfix{
  package{'postfix':
    ensure => 'installed'}
  
  service{'postfix':
    require => Package['postfix'],
    subscribe => File['main.cf']}
  
  file{'main.cf':
    path => '/etc/postfix/main.cf',
    content => template('main.erb'),
    notify => Service['postfix']}
}