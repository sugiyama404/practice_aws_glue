resource "aws_glue_crawler" "my_crawler" {
  name          = "my_crawler"
  database_name = var.db_name
  role          = var.glue_role_arn

  jdbc_target {
    connection_name = aws_glue_connection.rds_to_glue.name
    path            = "${var.db_name}/%"
  }

  schema_change_policy {
    delete_behavior = "LOG"
  }
}
