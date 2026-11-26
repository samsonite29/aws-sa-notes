variable "vpc_name" {
  type = string
  default = "Mount Gundabad"
  description = "Name of the VPC"
}


variable "private_subnets" {
  type = map(object({
    cidr_block = string
    availability_zone = string
  }))
}

variable "public_subnets" {
    type = map(object({
    cidr_block = string
    availability_zone = string
  }))
}