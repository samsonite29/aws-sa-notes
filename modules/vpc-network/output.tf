output "subnet_id" {
  description = "Subnet Id"
  value       = data.aws_subnet.default_subnet.id
}

output "security_group_id" {
  description = "Security Group Id"
  value =  aws_security_group.allow_web_ssh.id
}

output "zones" {
  description = "All availability zones"
  value = data.aws_availability_zones.available.names
}