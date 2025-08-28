
resource "aws_security_group" "public_sg" {
  name = "${var.project_name}-public-sg"
  description = "Security Group para EC2 publica"
  vpc_id = var.vpc_id

  # HTTP abierto a todos
  ingress {
	description = "HTTP"
	from_port = 80
	to_port = 80
	protocol = "tcp"
	cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH solo desde mi IP
  ingress {
	description = "SSH"
	from_port = 22
	to_port = 22
	protocol = "tcp"
	cidr_blocks = [var.my_ip]
  }

  # Salida libre (necesaria para que la instacia EC2 tenga salida)
  egress {
	from_port = 0
	to_port = 0
	protocol = "-1"
	cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
	Name = "${var.project_name}-public-sg"
  }
}

# SG para EC2 privada 
resource "aws_security_group" "private_sg" {
	name = "${var.project_name}-private-sg"
	description = "Security Group para la instancia EC2 privada"
	vpc_id = var.vpc_id

	# Acá solo se debe permitir el tráfico solo desde la Subnet Pública (10.0.1.0/24)
	ingress {
		description = "Access from public subnet"
		from_port = 0
		to_port = 65535
		protocol = "tcp"
		cidr_blocks = [var.public_subnet_cidr]
	}

	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	tags = {
	  Name = "${var.project_name}-private-sg"
	}
  
}