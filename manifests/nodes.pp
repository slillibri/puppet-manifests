node 'li91-20.members.linode.com' {
  $tcp_packets = {'0/0' => ['22', '80'],
                  '74.207.254.152' => ['8139', '5672']}

  $icmp_packets = ['0/0:8', '0/0:11']
  $logwatch_mailto = 'scott.lillibridge@gmail.com'
  
  $nginxservername = 'localhost'
  $nginxport = '8081'
  $nginxroot = '/var/www'
  $nginxindex = 'index.html'
  $geoport = '8081'
  
  include base
  include iptables
  include postfix
  include cassandra
  include imagemagick
  include gems
  include rabbitmq
  include stocks
  include nagios
  include nagios::target
  
  include nginx::geoip
  
  gem_install{'amqp': required => Class['development']}
  gem_install{'gruff': required => Package['rmagick']}
  gem_install{'rmagick': required => Class['imagemagick']}
  gem_install{'uuid': required => false}
  gem_install{'log4r': required => false}
  
  @@nagios_service{"check_web_auth_$hostname":
    target => "/etc/nagios3/conf.d/$hostname.cfg",
    check_command => 'check_web_auth!scott:password',
    use => 'generic-service',
    service_description => 'HTTP',
    host_name => "$fqdn"}
}

node 'li96-152.members.linode.com' {
  $tcp_packets = {'0/0' => ['22','80', '3128'],
                  '74.207.249.20' => ['8140','5666']}
                  
  $icmp_packets = ['0/0:8', '0/0:11']
  $nrpe_host = '74.207.249.20'
  
  include nagios::target
  include sshd
  include squid
  include iptables
  include users
  include sudo
  include nrpe  
}