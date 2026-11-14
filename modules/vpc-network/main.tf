################################
### All things networking for Computing ####
################################


locals {
  is_alb_sg = try(length(trimspace(var.public_alb_sg_id)) > 0, false)
}


# Lookup for default vpc id
data "aws_vpc" "default_vpc" {
  default = true
}

# Lookup for AZs
data "aws_availability_zones" "available" {}

data "aws_subnet" "az_a" {
  vpc_id            = data.aws_vpc.default_vpc.id
  availability_zone = "eu-west-1a"
}

data "aws_subnet" "az_b" {
  vpc_id            = data.aws_vpc.default_vpc.id
  availability_zone = "eu-west-1b"
}


resource "aws_security_group" "web_sg" {
  name        = "allow_web_ssh"
  description = "Allow web inbound traffic"
  vpc_id      = data.aws_vpc.default_vpc.id
   // prevent operations from hanging indefinitely
  timeouts {
    delete = "5m"
  }

  lifecycle {
    create_before_destroy = true
  }
}
# Ingress - Traffic going into your system . Ingress rules: who can initiate a connection to you.
# Egress - Traffic going out of your system. Egress rules: what you're allowed to initiate a connection to.
# SSH is 22, FTP is 21, SFTP is also 22 , RDO is 3389, HTTP is 80 and HTTPS is 443

// Cerificated Needed to run this
# resource "aws_vpc_security_group_ingress_rule" "allow_web_ssh_https_ipv4_ingress" {
#   security_group_id = aws_security_group.allow_web_ssh.id

#   cidr_ipv4   = "0.0.0.0/0"
#   from_port   = 443
#   ip_protocol = "tcp"
#   to_port     = 443
# }

### Either open to all HTTP traffic or from an ALB
resource "aws_vpc_security_group_ingress_rule" "allow_web_http_ipv4_ingress" {
  security_group_id = aws_security_group.web_sg.id

  cidr_ipv4   = local.is_alb_sg ? null : "0.0.0.0/0"
  referenced_security_group_id = local.is_alb_sg ? var.public_alb_sg_id : null
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}


resource "aws_vpc_security_group_egress_rule" "allow_all_ipv4_egress" {
  security_group_id = aws_security_group.web_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}


# Elastic IP
# resource "aws_eip" "lb"{
#   instance = aws_instance.instance.id
#   domain   = "vpc"
# }
