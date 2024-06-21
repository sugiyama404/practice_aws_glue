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

# SecurityGroup for glue
resource "aws_security_group" "glue_sg" {
  name   = "glue-sg"
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.app_name}-glue-sg"
  }
}


resource "aws_security_group" "redshift_sg" {
  name   = "redshift_sg"
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.app_name}-redshift-sg"
  }
}


