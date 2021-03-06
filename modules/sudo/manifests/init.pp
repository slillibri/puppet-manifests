class sudo {
  package  { sudo: ensure => [installed, '1.6.9p17-2'] }

  file { "/etc/sudoers":
    owner => "root",
    group => "root",
    mode => 440,
    content => template("sudoers", "$hostname.sudo"),
    require => Package["sudo"]
  }
}

