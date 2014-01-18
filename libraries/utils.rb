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
