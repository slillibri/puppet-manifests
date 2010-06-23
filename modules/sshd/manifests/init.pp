class sshd{
  service{'ssh': 
    require => Package['openssh-server'],
    ensure => 'running'}
  
  package{'openssh-server':
    ensure => 'installed'}
  
  file{'sshd_config':
    name => '/etc/ssh/sshd_config',
    owner => 'root',
    group => 'root',
    mode => '644',
    source => 'puppet:///modules/sshd/sshd_config',
    notify => Service['ssh']}

    @@nagios_service{"check_ssh_$hostname":
      check_command => 'check_ssh',
      use => 'generic-service',
      target => '/etc/nagios3/nagios_service.cfg',
      service_description => 'Check SSH',
      host_name => "$fqdn"}
}