resource "aws_instance" "public_ec2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.public_sg_id]
  associate_public_ip_address = true

  key_name             = var.key_name
  iam_instance_profile = var.iam_instance_profile

  user_data = <<EOF
#!/bin/bash
# ==== Actualizar paquetes ====
dnf update -y

# ==== Instalar CloudWatch Agent ====
dnf install -y amazon-cloudwatch-agent

# ==== Configurar CloudWatch para leer logs de PM2 ====
cat > /opt/aws/amazon-cloudwatch-agent/bin/config.json <<EOT
{
	"logs": {
	"logs_collected": {
		"files": {
		"collect_list": [
			{
			"file_path": "/home/ec2-user/.pm2/logs/node-app-out.log",
			"log_group_name": "/${var.project_name}/app",
			"log_stream_name": "${var.project_name}-out"
			},
			{
			"file_path": "/home/ec2-user/.pm2/logs/node-app-error.log",
			"log_group_name": "/${var.project_name}/app",
			"log_stream_name": "${var.project_name}-err"
			}
		]
		}
	}
	}
}
EOT

# ==== Iniciar CloudWatch Agent ====
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
	-a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json -s
  EOF

  tags = {
    Name        = "${var.project_name}-public-ec2"
    Environment = "dev"
  }
}

# ===========================
# Inicialización DB
# ===========================
resource "null_resource" "init_db" {
  depends_on = [aws_instance.public_ec2]

  # Subir script SQL
  provisioner "file" {
    source      = "./scripts/init.sql"
    destination = "/home/ec2-user/init.sql"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      host        = aws_instance.public_ec2.public_ip
      private_key = file("./my-key-pair.pem")
    }
  }

  # Subir script setup.sh con variables interpoladas
  provisioner "file" {
    content = templatefile("./scripts/setup.sh", {
      db_endpoint = var.db_endpoint
      db_username = var.db_username
      db_password = var.db_password
      db_name     = var.db_name
    })
    destination = "/home/ec2-user/setup.sh"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      host        = aws_instance.public_ec2.public_ip
      private_key = file("./my-key-pair.pem")
    }
  }

  # Ejecutar script setup.sh
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ec2-user"
      host        = aws_instance.public_ec2.public_ip
      private_key = file("./my-key-pair.pem")
    }

    inline = [
      "bash /home/ec2-user/setup.sh"
    ]
  }

  triggers = {
    always_run = timestamp()
  }
}
