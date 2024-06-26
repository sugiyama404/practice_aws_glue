resource "aws_vpc_endpoint" "glue_s3" {
  service_name      = "com.amazonaws.ap-northeast-1.s3"
  vpc_endpoint_type = "Gateway"
  vpc_id            = aws_vpc.main.id
  route_table_ids   = [aws_route_table.private_rt.id]

  tags = {
    "Name" = "ecr-s3-endpoint"
  }
}
