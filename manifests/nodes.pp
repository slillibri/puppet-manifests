node 'basenode' {
  include development
  include sudo
  include rsync
  include users
  include sshd
  include postfix
  include logwatch
  include hostname
}

node 'li91-20.members.linode.com' inherits 'basenode' {
	$tcp_packets = ['0/0:22', '127.0.0.1:9160', '74.207.254.152:8139']
  $icmp_packets = ['0/0:8', '0/0:11']
  $logwatch_mailto = 'scott.lillibridge@gmail.com'

	include cassandra
	include imagemagick
	include gems  
  include iptables
}
