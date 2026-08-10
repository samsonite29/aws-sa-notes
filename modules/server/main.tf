################################
### All things EC2 servers ####
################################

data "aws_ami" "image" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }
}

resource "aws_instance" "instance" {
  ami                    = data.aws_ami.image.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  user_data              = var.user_data
}


# Elastic Network Interface

resource "aws_network_interface" "web_network_interface" {
  subnet_id       = var.subnet_id
  security_groups = var.security_group_ids
  description = "Secondary ENI"

  attachment {
    instance     = aws_instance.instance.id
    device_index = 1
  }
}
