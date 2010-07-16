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
  
  @@nagios_service{"check_web_$hostname":
    check_command => 'check_http',
    use => 'generic-service',
    target => "/etc/nagios3/conf.d/$hostname.cfg",
    service_description => 'Check web',
    host_name => "$fqdn"}
    
  @@nagios_service{"check_nginx_$hostname":
    check_command => 'check_nginx',
    use => 'generic_service',
    target => '/etc/nagios3/conf.d/$hostname.cfg',
    service_description => 'Check nginx',
    host_name => "$fqdn"}
    
  @@nagios_command{"check_nginx":
    command_line => "/usr/lib/nginx/plugins/check_http -H $HOSTNAME$ -I $HOSTADDRESS$ -p $nginx_port",
    target => '/etc/nagios3/nagios_commands.cfg',
    command_name => 'check_nginx'}
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
      require => Package['nginx'],
      notify => Service['nginx']}
}