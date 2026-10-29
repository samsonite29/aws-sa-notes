####################################################################### 
#### This is an example of a simple EC2 instance referencing #########
#### network security and network connectivity resources.    #########
#### To run this on AWS, Just remove the comments            #########
####################################################################### 

# module "instance_network" {
#   source = "./modules/vpc-network"
# }

# module "ec2_instance" {
#   source             = "./modules/ec2-instance"
#   instance_type      = "t3.micro"
#   user_data          = file("user_data.sh")
#   subnet_id          = module.instance_network.subnet_id
#   security_group_ids = [module.instance_network.security_group_id]
#   zone               = module.instance_network.zones[0]
#   ebs_size           = 2
# }


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
