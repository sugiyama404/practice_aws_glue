output "db_address" {
  value = split(":", "${aws_db_instance.source-db.address}")[0]
}
