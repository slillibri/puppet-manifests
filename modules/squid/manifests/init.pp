class squid{
  package{"squid3": ensure => 'installed'}
  
  service{"squid3":
    ensure => 'running',
    require => Package['squid3'],
    subscribe => [File['squid.conf'], File['squid_passwd']]}
  
  file{"squid.conf":
    path => '/etc/squid3/squid.conf',
    owner => 'root', group => 'root', mode => 644,
    source => 'puppet:///modules/squid/squid.conf',
    require => Package['squid']}
  
  file{'squid_passwd':
    path => '/etc/squid3/squid_passwd',
    owner => 'root', group => 'root', mode => 644,
    source => 'puppet:///modules/squid/squid_passwd',
    require => Package['squid']}
}