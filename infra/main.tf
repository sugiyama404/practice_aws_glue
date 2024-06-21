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
  source           = "./modules/iam"
  app_name         = var.app_name
  region           = var.region
  s3_bucket_name   = module.s3.s3_bucket_name
  kendra_index_arn = module.kendra.kendra_index_arn
}

# network
module "network" {
  source   = "./modules/network"
  app_name = var.app_name
}

# rds
module "rds" {
  source           = "./modules/rds"
  db_sbg_name      = module.network.db_sbg_name
  sg_rds_source_id = module.network.sg_rds_source_id
  db_ports         = var.db_ports
  app_name         = var.app_name
  db_name          = var.db_name
  db_username      = var.db_username
  db_password      = var.db_password
}

# opmng
module "ec2" {
  source                     = "./modules/ec2"
  app_name                   = var.app_name
  sg_opmng_id                = module.network.sg_opmng_id
  subnet_public_subnet_1a_id = module.network.subnet_public_subnet_1a_id
  sorce_db_address           = module.rds.sorce_db_address
  db_username                = var.db_username
  db_name                    = var.db_name
  db_password                = var.db_password
}

# redshift
module "redshift" {
  source         = "./modules/redshift"
  redshift-sg-id = module.network.redshift-sg-id
}

# glue
module "glue" {
  source = "./modules/glue"
}




