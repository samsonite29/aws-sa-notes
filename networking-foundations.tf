#################################################################################################################
#### This is file demostrates networking foundations in  AWS services #########
#### Connectivity - VPC, Subnets
#### To run this on AWS, Just remove the comments !!!
###################################################################################################################




data "aws_availability_zones" "az" {}

locals {
    
  env_subnets = {
    "public-az1" = { cidr_block = "10.0.0.0/24", availability_zone = data.aws_availability_zones.az.names[0]}
    "public-az2" = { cidr_block = "10.0.1.0/24", availability_zone = data.aws_availability_zones.az.names[1]}
    "private-az1" = { cidr_block = "10.0.16.0/20", availability_zone = data.aws_availability_zones.az.names[0] }
    "private-az2" = { cidr_block = "10.0.32.0/20", availability_zone = data.aws_availability_zones.az.names[1] }
 }

 
}
module "network_foundations" {
  source = "./modules/vpc"
  subnets = local.env_subnets
}
