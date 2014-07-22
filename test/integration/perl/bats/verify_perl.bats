@test "perl has access to dbi and dbd::oracle." {
  result=$(perl -e "use DBI; use DBD::Oracle;")
  [ -z "$result" ]
}
