resource "aws_glue_connection" "rds_to_glue" {
  name = "rds-to-glue"
  connection_properties = {
    "JDBC_CONNECTION_URL" = "jdbc:mysql://${var.db_address}:3306/${var.db_name}"
    "USERNAME"            = var.db_username
    "PASSWORD"            = var.db_password
  }
  physical_connection_requirements {
    availability_zone      = var.region
    security_group_id_list = [var.security-group-rds-id]
    subnet_id              = var.subnet-private-subnet-1a-id
  }
}

# resource "aws_glue_connection" "glue_to_redshift" {
#   name = "glue-to-redshift"
#   connection_properties = {
#     JDBC_CONNECTION_URL = "jdbc:postgresql://${var.redshift-endpoint}/${var.db_name}"
#     "USERNAME"          = var.db_username
#     "PASSWORD"          = var.db_password
#   }
#   physical_connection_requirements {
#     availability_zone      = var.region
#     security_group_id_list = [var.security-group-redshift-id]
#     subnet_id              = var.subnet-private-subnet-1a-id
#   }
# }
