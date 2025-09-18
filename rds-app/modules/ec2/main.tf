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
		# ==== Actualizar paquetes ====
		dnf update -y

		# ==== Instalar Node.js 18 y git ====
		curl -fsSL https://rpm.nodesource.com/setup_18.x | bash -
		dnf install -y nodejs git

		# ==== Instalar PM2 ====
		npm install -g pm2

		# ==== Clonar repositorio ====
		cd /home/ec2-user
		git clone https://github.com/Junior-Jurado/ApiDesignacionTareas.git
		cd ApiDesignacionTareas

		# Cambiar a la rama aws
		git checkout aws

		# Instalar dependencias
		npm install

		# Iniciar app con PM2
		pm2 start server.js --name node-app
		pm2 startup systemd -u ec2-user --hp /home/ec2-user
		pm2 save

		# ==== Instalar y configurar CloudWatch Agent ====
		yum install -y amazon-cloudwatch-agent

		cat <<EOT >> /opt/aws/amazon-cloudwatch-agent/bin/config.json
		{
		"logs": {
			"logs_collected": {
			"files": {
				"collect_list": [
				{
					"file_path": "/home/ec2-user/ApiDesignacionTareas/logs/app.log",
					"log_group_name": "/${var.project_name}/app",
					"log_stream_name": "${var.project_name}-app-stream"
				}
				]
			}
			}
		}
		}
		EOT

		/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
		-a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json -s
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