Description
===========

This cookbook is used to configure a system with the Oracle Instant Client and, optionally, SQL*Plus. The primary objective is to let you interact with remote Oracle servers easily.

Requirements
============

You must download the RPMs in advance from Oracle yourself and accept the EULA. The RPMs must be placed on a server that can serve it up over HTTP, and you must set the URLs to the Instant Client and SQL*Plus RPMs.

## Platforms

Only tested with:

* Red Hat Enterprise Linux 5
* Red Hat Enterprise Linux 6

and variants (Oracle Enterprise Linux, CentOS, Scientific)

Usage
=====

Add the default recipe to your run list. This will install just Instant Client.

Attributes
==========

* `node['oracle-instantclient']['public-url']` - The URL of where you are hosting the RPMs
* `node['oracle-instantclient']['sqlplus-rpm']` - The filename of the SQL*Plus RPM
* `node['oracle-instantclient']['basic-rpm']` - The filename of the basic Instant Client RPM
* `node['oracle-instantclient']['version'] - The version of Oracle e.g. "12.1" - as used by rpm 
   installation prefix in "/usr/lib/oracle/<version>"
* `node['oracle-instantclient']['sdk-rpm']` - The filename of the basic development libraries (used by ruby recipe)

Recipes
=======

default
-------

The default recipe installs only the basic Instant Client.

ruby
----

The ruby recipe will install the OCI8 driver for Ruby. You need a compiler on the system, since this will build native extensions against the development libraries.

sdk
---

The sdk recipe will install Instant Client's devel package.

sqlplus
-------

The sqlplus recipe will install both the Instant Client and SQL*Plus.

Author and License
==================

- Author:: Julian C. Dunn (<jdunn@opscode.com>)
- Contributor:: Friedrich Clausen <friedrich.clausen@blackboard.com>
- Copyright:: 2013-2014, Chef Software, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
