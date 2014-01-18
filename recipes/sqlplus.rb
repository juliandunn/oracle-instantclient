#
# Cookbook Name:: oracle-instantclient
# Recipe:: sqlplus
# Author:: Julian C. Dunn (<jdunn@getchef.com>)
#
# Copyright (C) 2013-2014 Chef Software, Inc.
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

class Chef::Recipe
  include OracleUtils
end

include_recipe 'oracle-instantclient'

remote_file File.join(Chef::Config[:file_cache_path], node['oracle-instantclient']['sqlplus-rpm']) do
  source node['oracle-instantclient']['public-url'] + node['oracle-instantclient']['sqlplus-rpm']
  action :create
end

yum_package 'oracle-instantclient12.1-sqlplus' do
  source File.join(Chef::Config[:file_cache_path], node['oracle-instantclient']['sqlplus-rpm'])
  action :install
end

execute 'ldconfig' do
  command 'ldconfig'
  action :nothing
end

client_arch = node['kernel']['machine'] == 'x86_64' ? 'client64' : 'client'
template '/etc/ld.so.conf.d/oracle-instantclient-86_64.conf' do
  source 'ld.so.conf.d/oracle-instantclient-86_64.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
      :version => node['oracle-instantclient']['version'],
      :client_arch => client_arch
  )
  notifies :run, 'execute[ldconfig]'
end

install_alternatives
