locals {
  opmng_sg_id_list = [
    { type = "ingress", port = "22" },
    { type = "egress", port = "80" },
    { type = "egress", port = "443" },
    { type = "egress", port = "${var.db_ports[0].internal}" },
  ]
}

# SecurityGroupRules for opmng
resource "aws_security_group_rule" "opmng_web" {
  for_each = { for i in local.opmng_sg_id_list : i.port => i }

  type              = each.value.type
  from_port         = tonumber(each.value.port)
  to_port           = tonumber(each.value.port)
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.opmng_sg.id
}


# SecurityGroupRules for source db
resource "aws_security_group_rule" "db_in_tcp3306_from_opmng" {
  type                     = "ingress"
  from_port                = var.db_ports[0].internal
  to_port                  = var.db_ports[0].external
  protocol                 = var.db_ports[0].protocol
  source_security_group_id = aws_security_group.opmng_sg.id
  security_group_id        = aws_security_group.rds_sg.id
}

resource "aws_security_group_rule" "db_in_tcp3306_from_opmng" {
  type                     = "ingress"
  from_port                = var.db_ports[0].internal
  to_port                  = var.db_ports[0].external
  protocol                 = var.db_ports[0].protocol
  source_security_group_id = aws_security_group.glue_sg.id
  security_group_id        = aws_security_group.rds_sg.id
}

resource "aws_security_group_rule" "db_in_tcp3306" {
  type              = "ingress"
  from_port         = var.db_ports[0].internal
  to_port           = var.db_ports[0].external
  protocol          = var.db_ports[0].protocol
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.rds_sg.id
}

# GlueGroupRules for source db
resource "aws_security_group_rule" "glue_in_tcp65535" {
  type              = "egress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.glue_sg.id
}

resource "aws_security_group_rule" "glue_out_tcp665535" {
  type              = "egress"
  from_port         = 5439
  to_port           = 5439
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.glue_sg.id
}


# RedshiftGroupRules for source db
resource "aws_security_group_rule" "redshift_in_tcp65535" {
  type              = "ingress"
  from_port         = 5439
  to_port           = 5439
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.redshift_sg.id
}

resource "aws_security_group_rule" "redshift_in_tcp65535" {
  type                     = "ingress"
  from_port                = 5439
  to_port                  = 5439
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.glue_sg.id
  security_group_id        = aws_security_group.redshift_sg.id
}

resource "aws_security_group_rule" "redshift_out_tcp665535" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.redshift_sg.id
}

