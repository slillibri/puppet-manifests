class nginx::base{
  package{'nginx':
    ensure => 'installed'}
  
  service{'nginx':
    ensure => 'running',
    subscribe => [File['nginx.conf'], File['default']]}
  
  file{'nginx.conf':
    path => '/etc/nginx/nginx.conf',
    owner => 'root', group => 'root', mode => 644,
    source => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx']}
  
  file{'default':
    path => '/etc/nginx/sites-available/default',
    owner => 'root', group => 'root', mode => 644,
    source => 'puppet:///modules/nginx/default',
    require => Package['nginx']}
}

class nginx::geoip inherits nginx::base{
    file{'geoip':
      path => '/etc/nginx/conf.d/geoip.conf',
      owner => 'root', group => 'root', mode => 644,
      source => 'puppet:///modules/nginx/geoip.conf',
      require => Package['nginx']}
    
    file{'geoip_country':
      path => '/etc/nginx/conf.d/GeoIP.dat',
      owner => 'root', group => 'root', mode => 644,
      source => 'puppet:///modules/nginx/GeoIP.dat',
      require => Package['nginx']
    }
    
    file{'geoip_city':
      path => '/etc/nginx/conf.d/GeoLiteCity.dat',
      owner => 'root', group => 'root', mode => 644,
      source => 'puppet:///modules/nginx/GeoLiteCity.dat',
      require => Package['nginx']
    }
    
    ##How do I add the geo conf in sites-enabled? Or add a seperate site??
    
    file{'geo_site':
      path => '/etc/nginx/sites-enabled/geo_site',
      owner => 'root', group => 'root', mode => 644,
      source => 'puppet:///modules/nginx/geo_site',
      require => Package['nginx']}
}