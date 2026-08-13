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

data "aws_region" "current" {} 

# EBS block 

# Secondary volumes, To make use of default volumes, Do a fetch
resource "aws_ebs_volume" "web_ebs" {
  availability_zone = var.zone
  size = var.ebs_size
}

# Snapshot for secondary volumes

resource "aws_ebs_snapshot" "web_ebs_snapshot" {
  volume_id = aws_ebs_volume.web_ebs.id
}

locals {
  ami_image = coalesce(var.ami_image, data.aws_ami.image.id)
}

resource "aws_instance" "instance" {
  ami                    = local.ami_image
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

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.web_ebs.id
  instance_id = aws_instance.instance.id
}