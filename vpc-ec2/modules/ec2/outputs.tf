output "public_ec2_id" {
	description = "ID de la instancia EC2 publica"
	value = aws_instance.public_ec2.id  
}

output "public_ec2_ip" {
	description = "IP publica de la instancia EC2"
	value = aws_instance.public_ec2.public_ip  
}