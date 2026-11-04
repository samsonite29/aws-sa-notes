####################################################################### 
#### This is an example of a simple EC2 instance referencing #########
#### network security and network connectivity resources.    #########
#### To run this on AWS, Just remove the comments            #########
####################################################################### 


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
}

module "ec2_instance" {
  source             = "./modules/ec2-instance"
  instance_type      = "t3.micro"
  user_data          = local.user_data_alpha
  subnet_id          = module.instance_network.subnet_id
  security_group_ids = [module.instance_network.security_group_id]
  zone               = module.instance_network.zones[0]
  ebs_size           = 2
  name               = local.alpha_name
}


module "ec2_instance_beta" {
  source             = "./modules/ec2-instance"
  instance_type      = "t3.micro"
  user_data          = local.user_data_beta
  subnet_id          = module.instance_network.subnet_id
  security_group_ids = [module.instance_network.security_group_id]
  zone               = module.instance_network.zones[0]
  ebs_size           = 2
  name               = local.beta_name
}



####################################################################### 
#### This is an example that shows you how to create an AMI  #########
#### from an EC2 and use the same AMI to lunch another EC2.  #########
#### To run this on AWS, Just remove the comments            #########
####################################################################### 



# module "instance_network" {
#   source = "./modules/vpc-network"
# }

# module "ec2_instance_alpha" {
#   source             = "./modules/ec2-instance"
#   instance_type      = "t3.micro"
#   user_data          = file("user_data.sh")
#   subnet_id          = module.instance_network.subnet_id
#   security_group_ids = [module.instance_network.security_group_id]
#   zone               = module.instance_network.zones[0]
#   ebs_size           = 8
# }

# resource "aws_ami_from_instance" "alpha_custom_ami" {
#   name                    = "alpha-ami"
#   source_instance_id      = module.ec2_instance_alpha.instance_id
#   // Prevent unexpected journey 
#    timeouts {
#     create = "60m"
#   }
# }

# module "ec2_instance_beta" {
#   source             = "./modules/ec2-instance"
#   instance_type      = "t3.micro"
#   ami_image          = aws_ami_from_instance.alpha_custom_ami.id
#   user_data          = file("server_status.sh")
#   subnet_id          = module.instance_network.subnet_id
#   security_group_ids = [module.instance_network.security_group_id]
#   zone               = module.instance_network.zones[0]
#   ebs_size           = 8
# }
