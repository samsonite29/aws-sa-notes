
output "security_group_id" {
  description = "Security Group Id"
  value =  aws_security_group.web_sg.id
}

output "subnet_az_a" {
  value = data.aws_subnet.az_a.id
}

output "subnet_az_b" {
  value = data.aws_subnet.az_b.id
}

output "subnet_az_c" {
  value = data.aws_subnet.az_c.id
}

output "zones" {
  description = "All availability zones"
  value = data.aws_availability_zones.az.names
}

output "vpc_id" {
  description = "VPC Id"
  value = data.aws_vpc.default_vpc.id
}


output "az_a" {
  value = data.aws_availability_zones.az.names[0]
}


output "az_b" {
  value = data.aws_availability_zones.az.names[1]
}


output "az_c" {
  value = data.aws_availability_zones.az.names[2]
}