@test "ruby gem is compiled and installed" {
  # Unset env vars that busser sets
  unset GEM_HOME GEM_PATH GEM_CACHE
  /opt/chef/embedded/bin/gem list | grep ruby-oci8
}
