output "zone_id" {
  description = "ID de la Hosted Zone"
  value = aws_route53_zone.this.zone_id
}

output "zone_name" {
  description = "Nombre de la Hosted Zone"
  value = aws_route53_zone.this.name
}