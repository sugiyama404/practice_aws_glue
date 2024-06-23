resource "aws_redshift_cluster" "example" {
  cluster_identifier  = "tf-redshift-cluster"
  database_name       = var.db_name
  master_username     = var.db_username
  master_password     = var.db_password
  node_type           = "dc1.large"
  cluster_type        = "single-node"
  publicly_accessible = false
  skip_final_snapshot = true

  vpc_security_group_ids = [var.redshift-subnet-group-id]
}
