// This simple terraform file shows you how to create an AMI from an EC2 
// and use the same AMI to lunch another EC2

module "instance_network" {
  source = "./modules/network"
}

module "ec2_instance_alpha" {
  source             = "./modules/server"
  instance_type      = "t3.micro"
  user_data          = file("user_data.sh")
  subnet_id          = module.instance_network.subnet_id
  security_group_ids = [module.instance_network.security_group_id]
  zone               = module.instance_network.zones[0]
  ebs_size           = 8
}

resource "aws_ami_from_instance" "alpha_custom_ami" {
  name                    = "alpha-ami"
  source_instance_id      = module.ec2_instance_alpha.instance_id
  // Prevent unexpected journey 
   timeouts {
    create = "60m"
  }
}

resource "aws_instance" "instance" {
  ami                    = aws_ami_from_instance.alpha_custom_ami.id
  instance_type          = "t3.micro"
  subnet_id              = module.instance_network.subnet_id
  vpc_security_group_ids = [module.instance_network.security_group_id]
  user_data              = file("server_status.sh")
}