module "ec2_instance" {
  source        = "./modules/server"
  instance_type = "t3.micro"
  user_data     = file("user_data.sh")
}


module "ec2_instance_two" {
  source        = "./modules/server"
  instance_type = "t3.micro"
  user_data     = file("user_data.sh")
}
