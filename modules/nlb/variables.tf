variable "name" {
  description = "Network Load Balancer Name"
  type = string
  validation {
    condition     = length(var.name) <= 19 && can(regex("^[a-z0-9]([a-z0-9-]*[a-z0-9])?$", var.name))
    error_message = "name must be 1-19 chars, lowercase letters, digits and hyphens, not starting or ending with a hyphen."
  }
}

variable "subnet_ids" {
  description = "Subnet IDs"
  type = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type = string
}


variable "instance_ids" {
  description = "A list of ec2 Instances"
  type = map(string)
}
