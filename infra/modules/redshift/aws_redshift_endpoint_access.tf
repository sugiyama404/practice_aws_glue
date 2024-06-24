resource "aws_redshift_endpoint_access" "main" {
  endpoint_name      = "main"
  subnet_group_name  = var.redshift-subnet-group-name
  cluster_identifier = aws_redshift_cluster.main-redshift.cluster_identifier
}
