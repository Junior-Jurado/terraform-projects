resource "aws_security_group" "alb_sg" {
  name = "${var.project_name}-alg-sg"
  description = "Allow HTTP"
  vpc_id = var.vpc_id

  ingress {
	from_port = 80
	to_port = 80
	protocol = "tcp"
	cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
	from_port = 0
	to_port = 0
	protocol = "-1"
	cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "asg_sg" {
  name = "${var.project_name}-asg-sg"
  description = "Allow from ALB SG only"
  vpc_id = var.vpc_id

  ingress {
	from_port = 80
	to_port = 80
	protocol = "tcp"
	security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
	from_port = 0
	to_port = 0
	protocol = "-1"
	cidr_blocks = ["0.0.0.0/0"]
  }
}
