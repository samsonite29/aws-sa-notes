resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
   tags = {
    Name = "${var.vpc_name}"
  }
}

// You can have multiple CIDR block in your VPC
# resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr" {
#   vpc_id     = aws_vpc.main.id
#   cidr_block = "10.1.0.0/16"
# }

resource "aws_subnet" "private" {
  for_each = var.private_subnets
  vpc_id     = aws_vpc.main.id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone
  tags = {
    Name = "subnet-${each.key}"
  }
}


resource "aws_subnet" "public" {
  for_each = var.public_subnets
  vpc_id     = aws_vpc.main.id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet-${each.key}"
  }
}