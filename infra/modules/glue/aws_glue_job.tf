resource "aws_glue_job" "my_glue_job" {
  name     = "my_glue_job"
  role_arn = var.glue_role_arn
  connections = [
    aws_glue_connection.rds_to_glue.name,
    aws_glue_connection.glue_to_redshift.name
  ]
  command {
    name            = "glueetl"
    script_location = "s3://${var.s3_bucket_name}/glue_script.py"
    python_version  = "3"
  }
  default_arguments = {
    "--JOB_NAME"          = "rds_to_redshift_job"
    "--REDSHIFT_DATABASE" = var.db_name
    "--REDSHIFT_USER"     = var.db_username
    "--REDSHIFT_PASSWORD" = var.db_password
    "--REDSHIFT_HOST"     = var.redshift-dns-name
    "--REDSHIFT_PORT"     = 5439
    "--RDS_DATABASE"      = var.db_name
    "--RDS_USER"          = var.db_username
    "--RDS_PASSWORD"      = var.db_password
    "--RDS_HOST"          = var.db_address
    "--RDS_PORT"          = 3306
  }
}
