class stocks{  
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
    
  exec{'/usr/local/bin/stockpublisher.rb':
    kill_proc => 'stockpublisher',
    require => File['stockpublisher']}
  
  exec{'/usr/local/bin/stockwatcher.rb':
    kill_proc => 'stockwatcher',
    require => File['stockwatcher'}

  define kill_proc($proc) {    
    exec{"ps axf | grep $proc | grep -v grep | awk {'print $1'} | xargs kill"}
  }
}