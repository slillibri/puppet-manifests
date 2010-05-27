class cassandra {
  package{'cassandra': 
    ensure => 'package',
    subscribe => File['cassandra_config']}
  
  file{'cassandra_config':
    name => '/etc/cassandra/storage-conf.xml',
    owner => 'root',
    group => 'root',
    mode => '644',
    source => 'puppet:///cassandra/storage-conf.xml',
    require => Package['cassandra']}
}