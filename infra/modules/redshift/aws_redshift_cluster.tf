resource "aws_redshift_cluster" "main-redshift" {
  cluster_identifier  = "main-redshift-cluster"
  database_name       = var.db_name
  master_username     = var.db_username
  master_password     = var.db_password
  node_type           = "dc2.large"
  cluster_type        = "single-node"
  publicly_accessible = false
  skip_final_snapshot = true

  vpc_security_group_ids = ["${var.security-group-redshift-id}"]
}
