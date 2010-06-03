class base{
  include development
  include sudo
  include rsync
  include users
  include sshd
  include hostname
  include logwatch
  package{'telnet': ensure => 'installed'}
}