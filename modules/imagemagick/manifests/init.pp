class imagemagick{
  package{'imagemagick': ensure => 'installed'}
  package{'libmagickcore-dev': ensure => 'installed'}
}