class iptables{
  package{'iptables': ensure => 'installed'}
  
  file{'/etc/network/if-up.d/iptables':
    owner => 'root',
    group => 'root',
    mode => 700,
    content => template('iptables.erb')}

  exec{'/etc/network/if-up.d/iptables':
    refreshonly => true,
    subscribe => File['/etc/network/if-up.d/iptables']}
}