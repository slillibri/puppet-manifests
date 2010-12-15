class iptables{
  package{'iptables': ensure => 'installed'}
  
  case $operatingsystem {
    debian: {include base::debian}
    centos: {include base::centos}
    default: {warning("No operating system: $operatingsystem defined")}
  }

  class debian{
  
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
  
  class centos{
    file{'/etc/sysconfig/iptables':
      owner => 'root', group => 'root', mode => 700,
      content => template('iptables.centos.erb')}
    
    service{'iptables':
      ensure => 'running',
      subscribe => File['/etc/sysconfig/iptables']}
  }
}