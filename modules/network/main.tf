################################
### All things networking ####
################################

# Lookup for default vpc id
data "aws_vpc" "default_vpc" {
  default = true
}

# Lookup for AZs
data "aws_availability_zones" "available" {}


# Lookup for default subnet id
data "aws_subnet" "default_subnet" {
  vpc_id            = data.aws_vpc.default_vpc.id
  availability_zone = data.aws_availability_zones.available.names[0]
  default_for_az    = true
}


resource "aws_security_group" "allow_web_ssh" {
  name        = "allow_web_ssh"
  description = "Allow web inbound traffic"
  vpc_id      = data.aws_vpc.default_vpc.id
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

resource "aws_vpc_security_group_ingress_rule" "allow_web_ssh_http_ipv4_ingress" {
  security_group_id = aws_security_group.allow_web_ssh.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_web_ssh_ipv4_ingress" {
  security_group_id = aws_security_group.allow_web_ssh.id
  cidr_ipv4         = "18.202.216.48/29"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_ipv4_egress" {
  security_group_id = aws_security_group.allow_web_ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}


# Elastic IP
# resource "aws_eip" "lb"{
#   instance = aws_instance.instance.id
#   domain   = "vpc"
# }