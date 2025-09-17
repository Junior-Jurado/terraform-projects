resource "aws_iam_role" "ec2_role" {
  name = "${var.project_name}-ec2-role"

  assume_role_policy = jsonencode({
	Version = "2012-10-17"
	Statement = [{
		Action = "sts:AssumeRole",
		Effect = "Allow",
		Principal = {
			Service = "ec2.amazonaws.com"
		}
	}]
  })
}

resource "aws_iam_role_policy" "ec2_policy" {
  name = "${var.project_name}-ec2-policy"
  role = aws_iam_role.ec2_role.id

  policy = jsonencode({
	Version = "2012-10-17"
	Statement = [
		{
			Effect = "Allow"
			Action = [
				"secretsmanager:GetSecretValue",
				"logs:CreateLogGroup",
				"logs:CreateLogStream",
				"logs:PutLogEvents"
			],
			Resource = "*"
		}
	]
  })
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.project_name}-ec2-profile"
  role = aws_iam_role.ec2_role.name
}