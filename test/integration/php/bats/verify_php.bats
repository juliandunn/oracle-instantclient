@test "php has access to oci8" {
  result=$(php --info | grep '^oci8$' | head -1)
  [ "$result" = "oci8" ]
}
