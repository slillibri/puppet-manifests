node 'li91-20.members.linode.com' {
	$tcp_packets = ['0/0:22', '127.0.0.1:9160', '74.207.254.152:8139']
  $icmp_packets = ['0/0:8', '0/0:11']
  $logwatch_mailto = 'scott.lillibridge@gmail.com'
  
  include base
	include cassandra
	include imagemagick
	include gems  
  include iptables
  include rabbitmq
  include stocks
  
  gems::gem_install{'amqp':}
#  gems::gem_install{'gruff': require => Package['rmagick']}
#  gems::gem_install{'rmagick': require => Class['imagemagick']}
  gems::gem_install{'uuid':}
  gems::gem_install{'log4r':}
}