class stocks{  
  file{'stockwatcher':
    name => '/usr/local/bin/stockwatcher.rb',
    source => 'puppet:///modules/stocks/stockwatcher.rb',
    owner => 'root',
    group => 'root',
    mode => '755',
    require => [Class['rabbitmq'],Class['cassandra'],Class['gems']]}
    
  file{'stockpublisher':
    name => '/usr/local/bin/stockpublisher.rb',
    source => 'puppet:///modules/stocks/stockpublisher.rb',
    owner => 'root',
    group => 'root',
    mode => '755',
    require => [Class['rabbitmq'],Class['gems']]}
    
  file{'colstats':
    name => '/usr/local/bin/colstats.rb',
    source => 'puppet:///modules/stocks/colstats.rb',
    owner => 'root',
    group => 'root',
    mode => '755',
    require => [Class['cassandra'],Class['gems']]}
    
  # exec{'/usr/local/bin/stockpublisher.rb':
  #   path => '/bin:/usr/bin',
  #   onlyif => 'ps axf | grep -qs [s]tockpublisher',
  #   require => File['stockpublisher']}
  # 
  # exec{'/usr/local/bin/stockwatcher.rb':
  #   path => '/bin:/usr/bin',
  #   onlyif => 'ps axf | grep -qs [s]tockwatcher',
  #   require => File['stockwatcher']}
}