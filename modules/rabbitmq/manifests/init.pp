class rabbitmq{
  service{'rabbitmq':
    require => Package['rabbitmq-server'],
    ensure => 'running'}
    
  package{'rabbitmq-server':
    ensure => 'installed'}
}