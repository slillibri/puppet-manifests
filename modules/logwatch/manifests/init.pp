class logwatch{
  package{'logwatch':
    ensure => 'installed'}
  
  package{'libsys-cpu-perl':
    ensure => $operatingsystem ? {
      debian => 'installed'}
  }

  file{'/usr/share/logwatch/default.conf/logwatch.conf':
    owner => 'root',
    group => 'root',
    mode => 644,
    content => template('logwatch.conf.erb'),
    require => Package['logwatch']}
}