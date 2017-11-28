class mariadb::server::debiancnf {
  if $::osfamily == 'Debian' and $debiansysmaint_password != undef {
    file { '/etc/mysql/debian.cnf':
      content => template('mariadb/debian.cnf.erb'),
      require => Package[$package_names],
    }
  }
}
