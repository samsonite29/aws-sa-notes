
variable "template_name" {
    type = string
    description = "The name of the template"
}

variable "user_data" {
    type = string
    description = "User data"
    default = null
}

variable "sg_id" {
  description = "Security Group Id"
  type = string
}

variable "subnet_id" {
  description = "Subnet Id"
  type = string
}

variable "enable_public_ip" {
  description = " Enable Public IP"
  type = bool
}