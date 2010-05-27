class stocks{
  service{'stockpublisher':
    require => File['stockpublisher'],
    ensure => 'running'}
  
  service{'stockwatcher':
    require => File['stockwatcher'],
    ensure => 'running'}
  
  file{'stockwatcher':
    name => '/usr/local/bin/stockwatcher.rb',
    source => 'puppet:///stocks/stockwatcher.rb',
    owner => 'root',
    group => 'root',
    mode => '755',
    require => [Class['rabbitmq'],Class['cassandra'],Class['gems']]}
    
  file{'stockpublisher':
    name => '/usr/local/bin/stockpublisher.rb',
    source => 'puppet:///stocks/stockpublisher.rb',
    owner => 'root',
    group => 'root',
    mode => '755',
    require => [Class['rabbitmq'],Class['gems']]}
    
  file{'colstats':
    name => '/usr/local/bin/colstats.rb',
    source => 'puppet:///stocks/colstats.rb',
    owner => 'root',
    group => 'root',
    mode => '755',
    require => [Class['cassandra'],Class['gems']]}
}