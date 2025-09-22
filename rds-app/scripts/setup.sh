#!/bin/bash
set -e  # Detener si algo falla

# Instalar PostgreSQL
sudo dnf install -y postgresql15

# Ejecutar script SQL
export PGPASSWORD="${db_password}"
psql -h ${db_endpoint} -U ${db_username} -d ${db_name} -f /home/ec2-user/init.sql

# ==== Instalar Node.js 18 y git ====
curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -
sudo dnf install -y nodejs git

# Instalar PM2 globalmente
sudo npm install -g pm2

# Clonar repositorio
cd /home/ec2-user
git clone https://github.com/Junior-Jurado/ApiDesignacionTareas.git ApiDesignacionTareas
cd ApiDesignacionTareas
git checkout aws
npm install

# Ajustar permisos
chown -R ec2-user:ec2-user /home/ec2-user
# Iniciar PM2
pm2 start server.js --name node-app
sudo env PATH=$PATH:/usr/bin pm2 startup systemd -u ec2-user --hp /home/ec2-user
pm2 save
