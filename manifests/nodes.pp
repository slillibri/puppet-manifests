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
	
	$tcp_packets = [{'dport' => 22}, 
	                {'source' => '127.0.0.1', 'dport' => '9160'},
	                {'source' => '74.207.254.152', dport => '8139'}]
  
  $icmp_packet = [{'type' => '8'}, {'type' => '11'}]
  
  include iptables
}
