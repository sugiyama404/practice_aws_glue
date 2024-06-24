resource "null_resource" "default" {
  provisioner "local-exec" {
    command = "aws s3 sync ../glue/src/ s3://${aws_s3_bucket.main.id}"
  }
}
