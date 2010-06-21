class gems{
  require development
  
  file {'/root/.gemrc':
    owner => 'root',
    group => 'root',
    mode  => 644,
    source => 'puppet:///modules/gems/gemsrc'}

  file{'/usr/local/bin/gem_manifest':
    owner => 'root',
    group => 'root',
    mode => 755,
    source => 'puppet:///modules/gems/gem_manifest'}

  exec{'/usr/local/bin/gem_manifest': 
    path => '/bin:/usr/bin',
    require => File['/usr/local/bin/gem_manifest'],
    subscribe => File['/usr/local/bin/gem_manifest'],
    refreshonly => true,
    logoutput => false}
}

define gem_install($required){
  if $required {
    package{$name:
      provider => 'gem',
      ensure => 'installed',
      require => $required}
  } else {
    package{$name:
      provider => 'gem',
      ensure => 'installed'}
  }
}
