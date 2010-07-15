class sudo {

        package  { sudo: ensure => [installed, '1.6.9p17-2'] }

        file { "/etc/sudoers":
          owner => "root",
          group => "root",
          mode => 440,
          content => template("sudoers", "$hostname"),
          require => Package["sudo"]
        }
        
        file {"local_sudoers":
          path => "/etc/sudoers.d/$hostname",
          owner => 'root', group => 'root', mode => 440,
          source => "puppet:///modules/sudo/$hostname",
          require => Package['sudo']}
}

