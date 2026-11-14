variable "name" {
  description = "Load Balancer Name"
  type = string
  validation {
    condition     = length(var.name) <= 19 && can(regex("^[a-z0-9]([a-z0-9-]*[a-z0-9])?$", var.name))
    error_message = "name must be 1-19 chars, lowercase letters, digits and hyphens, not starting or ending with a hyphen."
  }
}

variable "vpc_id" {
  description = "VPC ID"
  type = string
}


variable "subnet_ids" {
  description = "Subnet IDs"
  type = list(string)
  validation {
    condition = length( var.subnet_ids) >= 2
    error_message = "At least two subnet IDs (in different AZs) are required."
  }
}

variable "instance_sg_id" {
  description = "Security group attached to EC2 instances"
  type        = string
}


variable "instance_ids" {
  description = "A list of ec2 Instances"
  type = set(string)
  
}


