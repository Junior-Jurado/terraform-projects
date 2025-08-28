# EC2 en subnet publica con Nginx instalado
resource "aws_instance" "public_ec2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.public_sg_id]
  associate_public_ip_address = true
  key_name                    = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y nginx
              systemctl enable nginx
              systemctl start nginx
              echo "<h1>Bienvenido a Nginx en Terraform</h1>" > /usr/share/nginx/html/index.html
              EOF

  tags = {
    Name = "${var.project_name}-public-ec2"
  }
}

# EC2 en subnet privada (solo accesible desde la pública)
resource "aws_instance" "private_ec2" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.private_subnet_id
  vpc_security_group_ids = [var.private_sg_id]
  associate_public_ip_address = false
  key_name = var.key_name

  tags = {
	Name = "${var.project_name}-private-ec2"
  }
}