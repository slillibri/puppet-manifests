class iptables{
  package{'iptables': ensure => 'installed'}
  
  $network = ['eth0', 'eth0:0', 'lo']
  
  file{'/etc/network/if-up.d/iptables':
    owner => 'root',
    group => 'root',
    mode => 700,
    content => template('iptables.erb')}

  file{'/etc/network/if-down.d/iptables':
    owner => 'root',
    group => 'root',
    mode => 700,
    source => 'puppet:///modules/iptables/iptables_down'}

  exec{'iptables':
    command => '/etc/network/if-up.d/iptables',
    refreshonly => true,
    subscribe => File['/etc/network/if-up.d/iptables']}
}