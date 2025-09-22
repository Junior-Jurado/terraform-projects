resource "aws_security_group" "public_sg" {
  name        = "${var.project_name}-public-sg"
  description = "Security Group para EC2 publica"
  vpc_id      = var.vpc_id

  # HTTP abierto a todos
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH solo desde mi IP
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  # Puerto Node Js
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Salida libre (necesaria para que la instacia EC2 tenga salida)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-public-sg"
  }
}

# SG dedicado para RDS
resource "aws_security_group" "rds_sg" {
  name        = "${var.project_name}-rds-sg"
  description = "Permitir acceso a RDS solo desde EC2 publica"
  vpc_id      = var.vpc_id

  # Acá solo se debe permitir el tráfico solo desde la Subnet Pública (10.0.1.0/24)
  ingress {
    description     = "Acceso Postgres para EC2 public SG"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.public_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-private-sg"
  }
}