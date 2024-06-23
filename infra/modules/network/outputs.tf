output "redshift-subnet-group-id" {
  value = aws_security_group.redshift_sg.id
}

output "rds-subnet-group-ids" {
  value = aws_db_subnet_group.db-subnet-group.id
}

output "security-group-rds-id" {
  value = aws_security_group.rds_sg.id
}

output "security-group-opmng-id" {
  value = aws_security_group.opmng_sg.id
}

output "subnet-private-subnet-1a-id" {
  value = aws_subnet.private_subnet_1a.id
}

output "subnet-public-subnet-1a-id" {
  value = aws_subnet.public_subnet_1a.id
}
