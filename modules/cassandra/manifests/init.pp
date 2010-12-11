class cassandra {
  service{'cassandra': 
    require => Package['cassandra']}
  
  package{'cassandra':
    name => 'cassandra',
    ensure => 'installed'}
  
  file{'cassandra_config':
    name => '/etc/cassandra/storage-conf.xml',
    owner => 'root',
    group => 'root',
    mode => '644',
    source => 'puppet:///modules/cassandra/storage-conf.xml',
    require => Package['cassandra'],
    notify => Service['cassandra']}
}