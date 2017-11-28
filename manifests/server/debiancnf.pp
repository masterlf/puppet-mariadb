# this class set a specific password for mysql debian service
#
class mariadb::server::debiancnf (
  $package_names           = $mariadb::params::server_package_names,
  $debiansysmaint_password = undef,
  ) inherits mariadb::params {
  if $::osfamily == 'Debian' and $debiansysmaint_password != undef {
    file { '/etc/mysql/debian.cnf':
      content => template('mariadb/debian.cnf.erb'),
      require => Package[$package_names],
    }
    database_user { 'debian-sys-maint@localhost':
      ensure        => present,
      password_hash => mysql_password($debiansysmaint_password),
      require       => Class['mariadb::server'],
    }
  }
}
