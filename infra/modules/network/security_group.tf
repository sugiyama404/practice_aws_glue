# SecurityGroup for RDS
resource "aws_security_group" "rds_sg" {
  name   = "rds-source-sg"
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.app_name}-rds-sg"
  }
}

# SecurityGroup for opmng
resource "aws_security_group" "opmng_sg" {
  name   = "opmng-sg"
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.app_name}-opmng-sg"
  }
}
