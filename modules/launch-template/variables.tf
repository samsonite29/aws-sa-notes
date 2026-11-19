
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