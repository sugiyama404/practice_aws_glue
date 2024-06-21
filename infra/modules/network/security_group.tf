# SecurityGroup for alb
resource "aws_security_group" "alb_sg" {
  name   = "alb-sg"
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.app_name}-alb-sg"
  }
}

# SecurityGroup for ecs
resource "aws_security_group" "ecs_sg" {
  name   = "ecs-sg"
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.app_name}-ecs-sg"
  }
}


# SecurityGroup for vpc_endpoint
resource "aws_security_group" "vpc_endpoint_sg" {
  name   = "vpc-endpoint-sg"
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.app_name}-vpc-endpoint-sg"
  }
}
