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
			  # Actualizar paquetes
              dnf update -y

			  # Instalar Node.js 18 y git
              curl -fsSL https://rpm.nodesource.com/setup_18.x | bash -
              dnf install -y nodejs git

			  # Instalar pm2 (para mantener app corriendo)
			  npm install -g pm2

			  # Clonar repositorio
			  cd /home/ec2-user
			  git clone https://github.com/Junior-Jurado/ApiDesignacionTareas.git
			  cd app

			  # Cambiar a la rama aws
			  git checkout aws

			  # Instalar dependencias
			  npm install

              # Iniciar app con PM2
			  pm2 start server.js --name node-app
			  pm2 startup systemd -u ec2-user --hp /home/ec2-user
			  pm2 save
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