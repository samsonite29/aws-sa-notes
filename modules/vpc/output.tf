output "vpc_id" {
  description = "VPC Id"
  value = aws_vpc.main.id
}

// result ["subnet-0123abc...", "subnet-0456def..."]

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = values(aws_subnet.public)[*].id
}

// result ["subnet-0123abc...", "subnet-0456def..."]
output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = values(aws_subnet.private)[*].id
}