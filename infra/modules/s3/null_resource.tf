resource "null_resource" "default" {
  provisioner "local-exec" {
    command = "aws s3 sync ${path.module}/../glue/src/ s3://${aws_s3_bucket.main.id}"
  }
}
