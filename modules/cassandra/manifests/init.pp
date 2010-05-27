class cassandra {
  service{'cassandra': 
    require => Package['cassandra-server'],
    ensure => 'running'}
  
  package{'cassandra-server':
    name => 'cassandra'
    ensure => 'installed'}
  
  file{'cassandra_config':
    name => '/etc/cassandra/storage-conf.xml',
    owner => 'root',
    group => 'root',
    mode => '644',
    source => 'puppet:///cassandra/storage-conf.xml',
    notify => Service['cassandra']}
    
}