class cassandra_server {
  service{'cassandra': 
    require => Package['cassandra_server'],
    ensure => 'running'}
  
  package{'cassandra_server':
    name => 'cassandra',
    ensure => 'installed'}
  
  file{'cassandra_config':
    name => '/etc/cassandra/storage-conf.xml',
    owner => 'root',
    group => 'root',
    mode => '644',
    source => 'puppet:///cassandra/storage-conf.xml',
    require => Package['cassandra_server'],
    notify => Service['cassandra']}
    
}