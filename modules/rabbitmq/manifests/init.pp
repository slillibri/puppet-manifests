class rabbitmq{
  package{'rabbitmq':
    ensure => 'running',
    require => Package['rabbitmq-server']}
}