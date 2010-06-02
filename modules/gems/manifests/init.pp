class gems{
  require development
  
  file {'/root/.gemrc':
    owner => 'root',
    group => 'root',
    mode  => 644,
    source => 'puppet:///gems/gemsrc'}

  file{'/usr/local/bin/gem_manifest':
    owner => 'root',
    group => 'root',
    mode => 755,
    source => 'puppet:///gems/gem_manifest'}

  exec{'/usr/local/bin/gem_manifest': 
    path => '/bin:/usr/bin',
    require => File['/usr/local/bin/gem_manifest'],
    unless => 'test -d /var/lib/gems/1.8/gems/cassandra-0.8.2',
    logoutput => false}

  define gems::gem_install($require) {
    if $require
      package{"${name}":
        provider => 'gem',
        ensure => 'installed',
        require => $require}
    else
      package{"${name}":
      provider => 'gem',
      ensure => 'installed'}
  }
}