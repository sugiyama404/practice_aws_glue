# SecurityGroupRules for source db
resource "aws_security_group_rule" "dbsource_in_tcp3306_from_opmng" {
  type                     = "ingress"
  from_port                = var.db_ports[0].internal
  to_port                  = var.db_ports[0].external
  protocol                 = var.db_ports[0].protocol
  source_security_group_id = aws_security_group.lambda_sg.id
  security_group_id        = aws_security_group.rds_source_sg.id
}
