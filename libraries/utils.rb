#
# Cookbook Name:: oracle-instantclient
# Library:: utils
# Author:: Friedrich Clausen <friedrich.clausen@blackboard.com>
#
# Copyright (C) 2014 Friedrich Clausen
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

require 'chef/mixin/shell_out'
include Chef::Mixin::ShellOut

# Helper methods for managing sqlplus
module OracleUtils
  def initialize(node)
    @node = node.to_hash
  end

  def install_alternatives
    bin_path = '/usr/bin/sqlplus'
    client_arch = @node['kernel']['machine'] == 'x86_64' ? 'client64' : 'client'
    Chef::Log.debug "OracleUtils: node[oracle-instantclient][version] is #{@node['oracle-instantclient']['version']}"
    alt_path = "/usr/lib/oracle/#{@node['oracle-instantclient']['version']}/#{client_arch}/bin/sqlplus"
    install_cmd = "update-alternatives --install #{bin_path} sqlplus #{alt_path} 1000"
    Chef::Log.debug install_cmd
    alternative_exists = shell_out("update-alternatives --display sqlplus | grep #{alt_path}").exitstatus == 0
    unless alternative_exists
      Chef::Log.debug 'OracleUtils: Adding alternative for sqlplus'
      install_result = shell_out(install_cmd)
      install_result.exitstatus == 0 || Chef::Application.fatal!('OracleUtils: Failed to set sqlplus alternative', 1)
    end
  end
end
