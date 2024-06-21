# ecs
resource "aws_iam_policy_attachment" "ecr_attach" {
  name       = "${var.app_name}_ecr_attach"
  roles      = ["${aws_iam_role.ecs_role.name}"]
  policy_arn = aws_iam_policy.ecr_policy.arn
}

resource "aws_iam_policy_attachment" "ecs_cloudwatch_attach" {
  name       = "${var.app_name}_ecs_cloudwatch_attach"
  roles      = ["${aws_iam_role.ecs_role.name}"]
  policy_arn = aws_iam_policy.ecs_cloudwatch_policy.arn
}

resource "aws_iam_policy_attachment" "ecs_apigateway_attach" {
  name       = "${var.app_name}_ecs_apigateway_attach"
  roles      = ["${aws_iam_role.ecs_role.name}"]
  policy_arn = aws_iam_policy.api_gateway_access.arn
}
