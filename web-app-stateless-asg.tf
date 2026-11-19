#################################################################################################################
#### This is file demostrates how to build a stateless web application using the following AWS services #########
#### Network Routing & Traffic Management - ALB
#### Compute - EC2, ASG
#### Network Security  - Security Group
#### Connectivity - Subnets
### ALB has a security group that allows egress to instance. Instance has a security group that allows ingress from ALB
#### To run this on AWS, Just remove the comments !!!
###################################################################################################################


# module "unicron_instance_network" {
#   source = "./modules/vpc-network"
#   public_lb_sg_id = module.unicron_alb.alb_sg_id
# }

# module "ec2_launch_template" {
#   source = "./modules/launch-template"
#   template_name = "asg-demo"
#    user_data = <<-EOF
#     #!/bin/bash
#     yum update -y
#     yum install -y httpd
#     systemctl start httpd
#     systemctl enable httpd
#     echo "<h1> From Unicron & $(hostname -f)</h1> with love" > /var/www/html/index.html
#   EOF
#   sg_id = module.unicron_instance_network.security_group_id
# }


# module "unicron_alb" {
#   source = "./modules/alb"
#   name = "unicron-lab"
#   subnet_ids = [module.unicron_instance_network.subnet_az_a, module.unicron_instance_network.subnet_az_b, module.unicron_instance_network.subnet_az_c]
#   vpc_id = module.unicron_instance_network.vpc_id
#   enable_instance_attachement = false
#   instance_sg_id = module.unicron_instance_network.security_group_id
# }

# module "unicron_asg" {
#   source = "./modules/asg"
#   name = "unicron-asg-demo"
#   launch_template_id = module.ec2_launch_template.launch_template_id
#   subnet_ids = [module.unicron_instance_network.subnet_az_a, module.unicron_instance_network.subnet_az_b, module.unicron_instance_network.subnet_az_c]
#   lb_target_group_arn = module.unicron_alb.lb_target_group
# }
