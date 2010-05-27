class development {
  package{"dpkg-dev": ensure => installed}
  package{"fakeroot": ensure => installed}
  package{"debhelper": ensure => installed}
  package{"libpcre3-dev": ensure => installed}
  package{"zlib1g-dev": ensure => installed}
  package{"libssl-dev": ensure => installed}
  package{"autotools-dev": ensure => installed}
  package{"libreadline5-dev": ensure => installed}
  package{"libmysqlclient15-dev": ensure => installed}
}
