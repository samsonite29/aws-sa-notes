variable "name" {
  description = "EC2 instance Name"
  type = string
  default = null
}

variable "launch_template_id" {
  description = "Launch ID"
  type        = string
}

variable "launch_template_version" {
  description = "Launch ID"
  type        = string
}