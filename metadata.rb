name 'oracle-instantclient'
maintainer 'Julian Dunn'
maintainer_email 'jdunn@getchef.com'
license 'Apache 2.0'
description 'Installs the Oracle Instant Client and SQL*Plus'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.1.0'

recipe 'oracle-instantclient::php', 'Add PHP recipe for Oracle Instant Client.'
recipe 'oracle-instantclient::perl', 'Add Perl recipe for Oracle Instant Client.'

depends 'build-essential'
depends 'cpan'
depends 'php'
