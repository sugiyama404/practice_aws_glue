resource "aws_glue_connection" "glue_to_rdb" {
  name = "glue_to_rdb"
  connection_properties = {
    "JDBC_CONNECTION_URL" = "jdbc:mysql://${var.db_address}:3306/${var.db_name}"
    "USERNAME"            = var.db_username
    "PASSWORD"            = var.db_password
  }
  physical_connection_requirements {
    availability_zone      = var.region
    security_group_id_list = [var.security-group-rds-id]
    subnet_id              = var.rds-subnet-group-ids[0]
  }
}
