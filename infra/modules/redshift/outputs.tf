output "redshift-endpoint" {
  value = aws_redshift_cluster.main-redshift.endpoint
}

output "redshift-dns-name" {
  value = aws_redshift_cluster.main-redshift.dns_name
}
