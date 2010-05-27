node 'li91-20.members.linode.com' {
	include sudo
	include rsync
	include users
	include cassandra_server
	include rabbitmq
	include sshd
	include imagemagick
	include gems
	include stocks
}
