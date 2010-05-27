class rabbitmq{
  package{'rabbitmq-server':
    ensure => 'running'
}