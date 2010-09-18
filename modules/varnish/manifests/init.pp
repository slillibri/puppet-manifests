class varnish{
  package{'varnish':
    ensure => 'installed'}
  
  service{'varnish':
    ensure => 'running',
    require => Package['varnish']}
}