class rabbitmq{
  service{'rabbitmq-server':
    require => Package['rabbitmq-server'],
    ensure => 'running'}
    
  package{'rabbitmq-server':
    ensure => 'installed'}
}