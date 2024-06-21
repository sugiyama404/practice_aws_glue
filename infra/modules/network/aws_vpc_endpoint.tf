resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.ap-northeast-1.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = [aws_subnet.private_subnet_1a.id]
  security_group_ids  = [aws_security_group.vpc_endpoint_sg.id]

  tags = {
    "Name" = "ecr-dkr-endpoint"
  }
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.ap-northeast-1.ecr.api"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = [aws_subnet.private_subnet_1a.id]
  security_group_ids  = [aws_security_group.vpc_endpoint_sg.id]

  tags = {
    "Name" = "ecr-api-endpoint"
  }
}

resource "aws_vpc_endpoint" "ecr_s3" {
  service_name      = "com.amazonaws.ap-northeast-1.s3"
  vpc_endpoint_type = "Gateway"
  vpc_id            = aws_vpc.main.id
  route_table_ids   = [aws_route_table.private_rt.id]

  tags = {
    "Name" = "ecr-s3-endpoint"
  }
}

resource "aws_vpc_endpoint" "logs" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.ap-northeast-1.logs"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = [aws_subnet.private_subnet_1a.id]
  security_group_ids  = [aws_security_group.vpc_endpoint_sg.id]

  tags = {
    "Name" = "logs-endpoint"
  }
}

resource "aws_vpc_endpoint" "api_gateway" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.ap-northeast-1.execute-api"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = [aws_subnet.private_subnet_1a.id]
  security_group_ids  = [aws_security_group.vpc_endpoint_sg.id]

  tags = {
    "Name" = "api-gateway-endpoint"
  }
}
