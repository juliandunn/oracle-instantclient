name             'oracle-instantclient'
maintainer       'Julian Dunn'
maintainer_email 'jdunn@getchef.com'
license          'Apache 2.0'
description      'Installs the Oracle Instant Client and SQL*Plus'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.5'

recipe           'oracle-instantclient::php', 'Add PHP recipe for Oracle Instant Client.'
depends          'php'
