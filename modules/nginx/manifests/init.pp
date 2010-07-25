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
    content => template('nginx_default.erb'),
    require => Package['nginx']}
  
  @@nagios_service{"check_web_$hostname":
    check_command => 'check_http',
    use => 'generic-service',
    target => "/etc/nagios3/conf.d/$hostname.cfg",
    service_description => 'Check web',
    host_name => "$fqdn"}
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
    
    file{'geo_site':
      path => '/etc/nginx/sites-enabled/geo_site',
      owner => 'root', group => 'root', mode => 644,
      source => 'puppet:///modules/nginx/geo_site',
      require => Package['nginx'],
      notify => Service['nginx']}
    
    @@nagios_command{"check_geoip":
      target => "/etc/nagios3/nagios_commands.cfg",
      command_line => '/usr/lib/nagios/plugins/check_http -I $HOSTADDRESS$ -p $ARG1$',
      command_name => 'check_geoip'}
    
    @@nagios_service{"check_geoip_$hostname":
      check_command => "check_geoip!$geoport",
      use => 'generic-service',
      target => "/etc/nagios3/conf.d/$hostname.cfg",
      service_description => 'geoip',
      host_name => "$fqdn"}
}