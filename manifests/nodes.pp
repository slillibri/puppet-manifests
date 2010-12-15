node 'li91-20.members.linode.com' {
  $tcp_packets = {'0/0' => ['2222', '80', '5222', '5223'],
                  '74.207.254.152' => ['8139', '5672', '7789','3306'],
                  '192.168.141.111' => ['7789','8081']}
  $icmp_packets = ['0/0:8', '0/0:11']
  $udp_packets = ['74.207.254.152:694', '127.0.0.1:23']
  
  $ipaddress_eth0_0 = '192.168.141.24'
  
  $logwatch_mailto = 'scott.lillibridge@gmail.com'
  
  $nginxservername = 'localhost'
  $nginxport = '8081'
  $nginxroot = '/var/www'
  $nginxindex = 'index.html'
  $geoport = '8081'
  
  $ejabberd_host = 'jabber.thereisnoarizona.org'
  $ejabberd_admin = 'admin'
  
  include base
  include iptables
  include postfix
  include cassandra
  include imagemagick
  include gems
  include rabbitmq
  include stocks
  # include nagios
  # include nagios::target
  
  include ejabberd
  include nginx::geoip
  
  gem_install{'amqp': required => [Class['development'], Package['ruby-dev']]}
  gem_install{'gruff': required => Package['rmagick']}
  gem_install{'rmagick': required => [Class['imagemagick'], Package['ruby-dev']]}
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
  $tcp_packets = {'0/0' => ['2222','80', '3128','6081'],
                  '74.207.249.20' => ['8140','5666','7789','3306','25'],
                  '192.168.141.24' => ['7789']}
  $icmp_packets = ['0/0:8', '0/0:11']
  $udp_packets = ['74.207.249.20:649']

  $nrpe_host = '74.207.249.20'
  
  $ipaddress_eth0_0 = '192.168.141.111'
  
  $logwatch_mailto = "scott.lillibridge@gmail.com"

  $varnish_host = "74.207.249.20"
  $varnish_port = "8081"
  
  include development
  include nagios::target
  include sshd
  include iptables
  include users
  include sudo
  include nrpe
  include logwatch
  include postfix
}