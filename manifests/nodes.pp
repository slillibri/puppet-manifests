node 'li91-20.members.linode.com' {
	$tcp_packets = ['0/0:22', '127.0.0.1:9160', '74.207.254.152:8139', '0/0:80']
  $icmp_packets = ['0/0:8', '0/0:11']
  $logwatch_mailto = 'scott.lillibridge@gmail.com'
  
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
}

node 'li96-152.members.linode.com' {
  $tcp_packets = ['0/0:22', '74.207.249.20:8140', '74.207.254.152:8140', '127.0.0.1:8140', '74.207.249.20:5666', '0/0:80', '0/0:3128']
  $icmp_packets = ['0/0:8', '0/0:11']
  
  include nagios::target
  include sshd
  include squid
  include iptables
  include sudo
}