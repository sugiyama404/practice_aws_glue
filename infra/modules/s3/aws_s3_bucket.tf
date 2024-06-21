resource "aws_s3_bucket" "main" {
  bucket        = "main-${random_string.s3_unique_key.result}"
  force_destroy = true
  tags = {
    Name = "${var.app_name}-main"
  }
}

resource "random_string" "s3_unique_key" {
  length  = 10
  upper   = false
  lower   = true
  numeric = true
  special = false
}
