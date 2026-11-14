#################################################################################################################
#### This is file demostrates how to build a stateless web application using the following AWS services #########
#### Network Routing & Traffic Management - ALB
#### Compute - EC2 
#### Network Security  - Security Group
#### Connectivity - Subnets
#### Request  ->  ALB Security Group  -> ALB -> Instance Security Group -> Instance
#### To run this on AWS, Just remove the comments !!!
###################################################################################################################



locals {
  alpha_name = "ALPHA"
  beta_name  = "BETA"

  user_data_alpha = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>${local.alpha_name} from $(hostname -f)</h1>" > /var/www/html/index.html
  EOF

  user_data_beta = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>${local.beta_name} from $(hostname -f)</h1>" > /var/www/html/index.html
  EOF

  
}


module "instance_network" {
  source = "./modules/vpc-network"
  public_alb_sg_id = module.alpha_beta_alb.alb_sg_id
}

module "ec2_instance_alpha" {
  source             = "./modules/ec2-instance"
  instance_type      = "t3.micro"
  user_data          = local.user_data_alpha
  subnet_id          = module.instance_network.subnet_az_a
  security_group_ids = [module.instance_network.security_group_id]
  zone               = module.instance_network.az_a
  ebs_size           = 2
  name               = local.alpha_name
}


module "ec2_instance_beta" {
  source             = "./modules/ec2-instance"
  instance_type      = "t3.micro"
  user_data          = local.user_data_beta
  subnet_id          = module.instance_network.subnet_az_b
  security_group_ids = [module.instance_network.security_group_id]
  zone               = module.instance_network.az_b
  ebs_size           = 2
  name               = local.beta_name
}


module "alpha_beta_alb"{
  source = "./modules/alb"
  name = "alpha-beta"
  vpc_id = module.instance_network.vpc_id
  subnet_ids = [module.instance_network.subnet_az_a, module.instance_network.subnet_az_b]
  instance_sg_id = module.instance_network.security_group_id
  instance_ids = {
    web_instance_alpha = module.ec2_instance_alpha.instance_id
    web_instance_beta = module.ec2_instance_beta.instance_id
  }
}