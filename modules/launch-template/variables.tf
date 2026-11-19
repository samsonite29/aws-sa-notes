
variable "template_name" {
    type = string
    description = "The name of the template"
}

variable "user_data" {
    type = string
    description = "User data"
    default = null
}