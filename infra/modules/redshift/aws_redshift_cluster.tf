resource "aws_redshift_cluster" "example" {
  cluster_identifier  = "tf-redshift-cluster"
  database_name       = "mydb"
  master_username     = "exampleuser"
  master_password     = "Mustbe8characters"
  node_type           = "dc1.large"
  cluster_type        = "single-node"
  publicly_accessible = false
  skip_final_snapshot = true

  vpc_security_group_ids = [var.redshift-sg-id]
}
