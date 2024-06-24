output "redshift-endpoint-address" {
  value = aws_redshift_endpoint_access.main.address
}

output "redshift-endpoint-endpoint" {
  value = aws_redshift_endpoint_access.main.endpoint_name
}
