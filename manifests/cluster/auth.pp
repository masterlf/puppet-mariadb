class mariadb::cluster::auth (
  $wsrep_sst_password,
  $wsrep_sst_user     = 'clsstusr',
) {

  database_user { "${wsrep_sst_user}@%":
    ensure        => present,
    password_hash => mysql_password($wsrep_sst_password),
    require       => Class['mariadb::server'],
  }

  database_grant { "${wsrep_sst_user}@%":
    privileges => [ 'all' ],
    require    => Database_user["${wsrep_sst_user}@%"],
  }

}
