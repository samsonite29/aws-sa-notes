variable "instance_type" {
  description = " Type of EC2 instance"
  type        = string
  default     = ""
}

variable "user_data" {
  description = "configuration script"
  type        = string
}