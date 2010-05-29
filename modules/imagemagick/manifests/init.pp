class imagemagick{
  package{'imagemagick': ensure => 'installed'}
  package{'libmagickcore-dev': ensure => 'installed'}
  package{'libmagickwand3': ensure => 'installed'}
  package{'libmagickwand-dev': ensure => 'installed'}
}