variable "app_name" {}
variable "region" {}
data "aws_caller_identity" "self" {}
locals {
  account_id = data.aws_caller_identity.self.account_id
}
