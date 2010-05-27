class gems{
  file {'/root/.gemrc':
    owner => 'root',
    group => 'root',
    mode  => 644,
    source => 'puppet:///rubygems/gemsrc'}
  
  package{'cassandra':
    provider => 'gem',
    ensure => 'installed'}
  
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
    provider => 'gem'
    ensure => 'installed'}
}