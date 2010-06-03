class logwatch{
  package{'logwatch':
    ensure => 'installed'}
  
  file{'/usr/share/logwatch/default.conf/logwatch.conf':
    owner => 'root',
    group => 'root',
    mode => 644,
    content => template('logwatch.conf.erb'),
    require => Package['logwatch']}
}