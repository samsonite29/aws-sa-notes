variable "instance_type" {
  description = " Type of EC2 instance"
  type        = string
  default     = ""
}

variable "user_data" {
  description = "configuration script"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "security_group_ids" {
  description = "Security group IDs"
  type = list(string)
}