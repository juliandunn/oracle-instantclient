#
# Cookbook Name:: oracle-instantclient
# Recipe:: default
#
# Copyright (C) 2013 Opscode, Inc.
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

client_arch = node[:kernel][:machine] == "x86_64" ? "client64" : "client"
template '/etc/ld.so.conf.d/oracle-instantclient-86_64.conf' do
    source 'ld.so.conf.d/oracle-instantclient-86_64.conf.erb'
    owner 'root'
    group 'root'
    mode '0644'
    variables ({
        :version => node['oracle-instantclient']['version'],
        :client_arch => client_arch
    })
end

remote_file File.join(Chef::Config[:file_cache_path], node['oracle-instantclient']['basic-rpm']) do
  source node['oracle-instantclient']['public-url'] + node['oracle-instantclient']['basic-rpm']
  action :create
end

yum_package 'oracle-instantclient12.1-basic' do
  source File.join(Chef::Config[:file_cache_path], node['oracle-instantclient']['basic-rpm'])
  action :install
end

