class opsview {
  package{'opsview':
    ensure => 'installed'}
  
  package{'opsview-agent':
    ensure => 'installed',
    require => Package['opsview']}
}