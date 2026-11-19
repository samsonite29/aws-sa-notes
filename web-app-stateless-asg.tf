#################################################################################################################
#### This is file demostrates how to build a stateless web application using the following AWS services #########
#### Network Routing & Traffic Management - ALB
#### Compute - EC2, ASG
#### Network Security  - Security Group
#### Connectivity - Subnets
#### To run this on AWS, Just remove the comments !!!
###################################################################################################################

module "ec2_launch_template" {
  source = "./modules/launch_template"
  template_name = "asg-demo"
   user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1> From Unicron & $(hostname -f)</h1> with love" > /var/www/html/index.html
  EOF
}

module "unicron_instance_network" {
  source = "./modules/vpc-network"
}

module "unicron_alb" {
  source = "./modules/alb"
  name = "unicron-lab"
  subnet_ids = [module.unicron_instance_network.az_a, module.unicron_instance_network.az_b, module.unicron_instance_network.az_c]
  vpc_id = module.instance_network.vpc_id
}

module "unicron_asg" {
  source = "./modules/asg"
  name = "unicron-asg-demo"
  launch_template_id = modeule.ec2_launch_template.id
  subnet_ids = [module.unicron_instance_network.az_a, module.unicron_instance_network.az_b, module.unicron_instance_network.az_c]
  lb_target_group_arn = module.unicron_alb.lb_target_group
}