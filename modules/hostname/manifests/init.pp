class hostname{
  file{'/etc/hostname':
    owner => 'root',
    group => 'root',
    mode => 644,
    content => template('hostname.erb')}
}