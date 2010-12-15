class logwatch{
  package{'logwatch':
    ensure => 'installed'}
  
  file{'/usr/share/logwatch/default.conf/logwatch.conf':
    owner => 'root',
    group => 'root',
    mode => 644,
    content => template('logwatch.conf.erb'),
    require => Package['logwatch']}
    
  case $operatingsystem {
    debian: {include logwatch::debian}
    centos: {include logwatch::centos}
    default: {warning("No such operating system: $operatingsystem defined yet")}
  }
    class debian{
      package{'libsys-cpu-perl':
        ensure => 'installed'}      
    }
    
    class centos{}
}