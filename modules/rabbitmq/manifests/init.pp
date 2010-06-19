class rabbitmq{
  service{'rabbitmq-server':
    require => Package['rabbitmq-server']}
    
  package{'rabbitmq-server':
    ensure => 'installed'}
}