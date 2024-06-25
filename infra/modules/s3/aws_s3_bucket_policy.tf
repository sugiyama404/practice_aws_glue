resource "aws_s3_bucket_policy" "allow_access" {
  bucket = aws_s3_bucket.main.id
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Sid": "AllowS3Download",
            "Principal": {
                "AWS": "arn:aws:iam::${local.account_id}:root"
            },
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::${aws_s3_bucket.main.bucket}/*"
            ]
        }
    ]
}
POLICY

}
