#################################################################################################################
#### This is file demostrates networking foundations in  AWS services #########
#### Connectivity - VPC, Subnets
#### To run this on AWS, Just remove the comments !!!
###################################################################################################################




data "aws_availability_zones" "az" {}

locals {
    
  private_subnets = {
   "private-az1" = { cidr_block = "10.0.16.0/20", availability_zone = data.aws_availability_zones.az.names[0] }
   "private-az2" = { cidr_block = "10.0.32.0/20", availability_zone = data.aws_availability_zones.az.names[1] }
 }
 public_subnets = {
    "public-az1" = { cidr_block = "10.0.0.0/24", availability_zone = data.aws_availability_zones.az.names[0]}
    "public-az2" = { cidr_block = "10.0.1.0/24", availability_zone = data.aws_availability_zones.az.names[1]}
 }
 
}


module "vpc" {
  source = "./modules/vpc"
  private_subnets = local.private_subnets
  public_subnets = local.public_subnets
}

module "security_group" {
  source = "./modules/security-group"
  sg_name = "nwt-fd"
  vpc_id = module.vpc.vpc_id
  ingress_ip_protocol = "SSH"
  ingress_from_port = 22
  ingress_to_port = 22
}

module "public_instance_launch_template" {
  source = "./modules/launch-template"
  template_name = "nwt-fd"
  enable_public_ip = true
   user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1> From Foundations with love & $(hostname -f)</h1> with love" > /var/www/html/index.html
  EOF
  sg_id = module.security_group.security_group_id
  subnet_id = module.vpc.public_subnet_ids[0]
}

module "instance" {
  source = "./modules/instance"
  launch_template_id = module.public_instance_launch_template.launch_template_id
  launch_template_version = "1"
}