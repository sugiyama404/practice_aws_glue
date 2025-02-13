resource "aws_db_instance" "source-db" {
  engine         = "mysql"
  engine_version = "8.0.35"

  identifier = "source-db"

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  instance_class = "db.t3.micro"

  allocated_storage     = 20
  max_allocated_storage = 50
  storage_type          = "gp2"
  storage_encrypted     = false

  multi_az               = false
  availability_zone      = "ap-northeast-1a"
  db_subnet_group_name   = var.rds-subnet-group-ids
  vpc_security_group_ids = ["${var.security-group-rds-id}"]
  publicly_accessible    = false
  port                   = var.db_ports[0].external

  parameter_group_name = aws_db_parameter_group.db-pg.name
  option_group_name    = aws_db_option_group.main_optiongroup.name

  backup_window              = "04:00-05:00"
  backup_retention_period    = 7
  maintenance_window         = "Mon:05:00-Mon:08:00"
  auto_minor_version_upgrade = false

  deletion_protection = false
  skip_final_snapshot = true

  apply_immediately = true

  tags = {
    Name = "${var.app_name}-source-db"
  }
}
