class gems{
  file {'/root/.gemrc':
    owner => 'root',
    group => 'root',
    mode  => 644,
    source => 'puppet:///gems/gemsrc'}

  file{'/usr/local/bin/gem_manifest':
    owner => 'root',
    group => 'root',
    mode => 644,
    source => 'puppet:///gems/gems_manifest'}

  exec{'/usr/local/bin/gem_manifest': 
    require => File['/usr/local/bin/gem_manifest'],
    logoutput => false}
  
  package{'amqp':
    provider => 'gem',
    ensure => 'installed'}
  
  package{'gruff':
    provider => 'gem',
    ensure => 'installed',
    require => Package['rmagick']}
  
  package{'rmagick':
    provider => 'gem',
    ensure => 'installed',
    require => Class['imagemagick']}
  
  package{'uuid':
    provider => 'gem',
    ensure => 'installed'}
  
  package{'log4r':
    provider => 'gem',
    ensure => 'installed'}
}