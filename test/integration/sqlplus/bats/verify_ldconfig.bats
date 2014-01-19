@test "libraries are resolved in sqlplus binary" {
  ldd "/usr/bin/sqlplus" | grep /usr/lib/oracle
}
