terraform {
  required_version = "=1.8.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# S3

module "s3" {
  source   = "./modules/s3"
  app_name = var.app_name
  region   = var.region
}

# IAM
module "iam" {
  source   = "./modules/iam"
  app_name = var.app_name
  region   = var.region
}

# network
module "network" {
  source   = "./modules/network"
  app_name = var.app_name
  db_ports = var.db_ports
}

# rds
module "rds" {
  source                = "./modules/rds"
  rds-subnet-group-ids  = module.network.rds-subnet-group-ids
  security-group-rds-id = module.network.security-group-rds-id
  db_ports              = var.db_ports
  app_name              = var.app_name
  db_name               = var.db_name
  db_username           = var.db_username
  db_password           = var.db_password
}

# opmng
module "ec2" {
  source                     = "./modules/ec2"
  app_name                   = var.app_name
  security-group-opmng-id    = module.network.security-group-opmng-id
  subnet-public-subnet-1a-id = module.network.subnet-public-subnet-1a-id
  db_address                 = module.rds.db_address
  db_username                = var.db_username
  db_name                    = var.db_name
  db_password                = var.db_password
}

# redshift
module "redshift" {
  source                     = "./modules/redshift"
  security-group-redshift-id = module.network.security-group-redshift-id
  redshift-subnet-group-name = module.network.redshift-subnet-group-name
  redshift-subnet-group-id   = module.network.redshift-subnet-group-id
  db_name                    = var.db_name
  db_username                = var.db_username
  db_password                = var.db_password
}

# glue
module "glue" {
  source                      = "./modules/glue"
  db_name                     = var.db_name
  db_username                 = var.db_username
  db_password                 = var.db_password
  db_address                  = module.rds.db_address
  security-group-rds-id       = module.network.security-group-rds-id
  redshift-endpoint-address   = module.redshift.redshift-endpoint-address
  subnet-private-subnet-1a-id = module.network.subnet-private-subnet-1a-id
  region                      = var.region
  s3_bucket_name              = module.s3.s3_bucket_name
  glue_role_arn               = module.iam.glue_role_arn
}




