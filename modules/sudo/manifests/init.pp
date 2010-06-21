class sudo {

        package  { sudo: ensure => [installed, '1.6.9p17-2'] }

        file { "/etc/sudoers":
                owner => "root",
                group => "root",
                mode => 440,
                source => "puppet:///modules/sudo/sudoers",
                require => Package["sudo"]
        }
}

