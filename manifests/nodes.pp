node 'basenode' {
  include development
  include sudo
  include rsync
  include users
  include sshd
}

node 'li91-20.members.linode.com' inherits 'basenode' {
	include cassandra
	include rabbitmq
	include imagemagick
	include gems
	include stocks
	
	$tcp_packets = ['0/0:22', '127.0.0.1:9160', '74.207.254.152:8139']
  
  include iptables
}
