# SecurityGroup for RDS
resource "aws_security_group" "rds_source_sg" {
  name   = "rds-source-sg"
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.app_name}-rds-source-sg"
  }
}
