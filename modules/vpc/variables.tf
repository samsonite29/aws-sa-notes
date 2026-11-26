variable "vpc_name" {
  type = string
  default = "Mount Gundabad"
  description = "Name of the VPC"
}


variable "subnets" {
  type = map(object({
    cidr_block = string
    availability_zone = string
  }))
}