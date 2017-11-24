# Class: mariadb::server::account_security
#
# class call in mariadb::config
# with variable $remove_default_accounts
# Some installations have some default users which are not required.
# We remove them here. You can subclass this class to overwrite this behavior.
#
# Actions:
#
# Requires:
#
#   class mariadb::server
#
# Usage:
#
class mariadb::server::account_security {
  database_user { [ "root@${::fqdn}", 'root@127.0.0.1', 'root@::1',
                    "@${::fqdn}", '@localhost', '@%' ]:
    ensure  => 'absent',
    require => Class['mariadb::server'],
  }
  if ($::fqdn != $::hostname) {
    database_user { ["root@${::hostname}", "@${::hostname}"]:
      ensure  => 'absent',
      require => Class['mariadb::server'],
    }
  }
  database { 'test':
    ensure  => 'absent',
    require => Class['mariadb::server'],
  }
}
