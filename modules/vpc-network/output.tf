
output "security_group_id" {
  description = "Security Group Id"
  value =  aws_security_group.allow_web_ssh.id
}

output "subnet_az_a" {
  value = data.aws_subnet.az_a.id
}

output "subnet_az_b" {
  value = data.aws_subnet.az_b.id
}

output "zones" {
  description = "All availability zones"
  value = data.aws_availability_zones.available.names
}

output "vpc_id" {
  description = "VPC Id"
  value = data.aws_vpc.default_vpc.id
}


output "az_a" {
  value = data.aws_availability_zones.available.names[0]
}


output "az_b" {
  value = data.aws_availability_zones.available.names[1]
}