# lambda
resource "aws_iam_role_policy_attachment" "vpc_lambda_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_to_s3_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "lambda_to_kendra" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_to_kendra.arn
}

# kendra and etc
resource "aws_iam_role_policy_attachment" "bedrock" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.bedrock.arn
}

resource "aws_iam_role_policy_attachment" "kendra" {
  role       = aws_iam_role.kendra_role.name
  policy_arn = aws_iam_policy.kendra_policy.arn
}

resource "aws_iam_role_policy_attachment" "cloudwatch" {
  role       = aws_iam_role.kendra_role.name
  policy_arn = aws_iam_policy.cloudwatch_policy.arn
}

