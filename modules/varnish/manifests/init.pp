class varnish{
  package{'varnish':
    ensure => 'installed'}
  
  service{'varnish':
    ensure => 'running',
    require => Package['varnish']}
  
  file{'varnish_defaults':
    path => '/etc/default/varnish',
    notify => Service['varnish'],
    owner => 'root', group => 'root', mode => '644',
    source => 'puppet:///modules/varnish/default'}
  
  file{'default.vcl':
    path => '/etc/varnish/default.vcl',
    notify => Service['varnish'],
    owner => 'root', group => 'root', mode => '644',
    content => template("$hostname.vcl.erb")}
}