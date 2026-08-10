module "instance_network" {
  source = "./modules/network"
}



module "ec2_instance" {
  source             = "./modules/server"
  instance_type      = "t3.micro"
  user_data          = file("user_data.sh")
  subnet_id          = module.instance_network.subnet_id
  security_group_ids = [module.instance_network.security_group_id]
}


module "ec2_instance_two" {
  source             = "./modules/server"
  instance_type      = "t3.micro"
  user_data          = file("user_data.sh")
  subnet_id          = module.instance_network.subnet_id
  security_group_ids = [module.instance_network.security_group_id]
}
