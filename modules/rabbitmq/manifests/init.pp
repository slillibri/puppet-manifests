class rabbitmq{
  service{'rabbitmq-server':
    require => Package['rabbitmq-server']}
    
  package{'rabbitmq-server':
    ensure => 'installed'}
  
  file{'check_queues':
    path => '/usr/lib/nagios/plugins/check_queues.rb',
    owner => 'root', group => 'root', mode => 755,
    source => 'puppet:///modules/rabbitmq/check_queues.rb'}
  
  @@nagios_command{'check_queues':
    command_line => '/usr/lib/nagios/plugins/check_queues.rb',
    target => '/etc/nagios3/nagios_commands.cfg',
    command_name => 'check_queues',
    require => File['check_queues']}
  
  @@nagios_service{'check_queues':
    target => "/etc/nagios3/conf.d/$hostname.cfg",
    use => 'generic-service',
    check_command => 'check_queues',
    service_description => 'Check RabbitMQ',
    require => File['check_queues']}
}