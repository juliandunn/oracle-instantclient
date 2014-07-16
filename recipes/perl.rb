#
# Cookbook Name:: oracle-instantclient
# Recipe:: perl
# Author:: David Kinzer <dtkinzer@gmail.com>
#
# Copyright (C) 2014 David Kinzer
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# @file
# Install Perl Oracle Instant Client via CPAN.
#
include_recipe 'cpan::bootstrap'
include_recipe 'oracle-instantclient::sdk'
include_recipe 'oracle-instantclient::sqlplus'

# Explicitly set LD_LIBRARY_PATH and ORACLE_HOME otherwise cpan complain on
# installing DBD::Oracle.
client_arch = node['kernel']['machine'] == 'x86_64' ? 'client64' : 'client'
ENV['LD_LIBRARY_PATH'] = "/usr/lib/oracle/#{node['oracle-instantclient']['version']}/#{client_arch}/lib"
ENV['ORACLE_HOME'] = ENV['LD_LIBRARY_PATH']

cpan_client 'DBI' do
  action 'install'
  install_type 'cpan_module'
end

cpan_client 'DBD::Oracle' do
  action 'install'
  install_type 'cpan_module'
end
