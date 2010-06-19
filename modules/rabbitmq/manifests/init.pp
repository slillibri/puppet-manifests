class rabbitmq{
  service{'rabbitmq-server':
    require => Package['rabbitmq-server'],
    ensure => 'running',
    provider => 'debian'}
    
  package{'rabbitmq-server':
    ensure => 'installed'}
}