module "ec2_instance" {
  source        = "./modules/server"
  instance_type = "t2.micro"
  user_data     = file("user_data.sh")
}