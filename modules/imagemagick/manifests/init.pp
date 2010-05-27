class imagemagick{
  package{'imagemagick': ensure => 'installed'}
  package{'libmagick9-dev': ensure => 'installed'}
}