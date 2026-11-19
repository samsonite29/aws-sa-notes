variable "name" {
    description = "ASG Name"
    type = string
}

variable "launch_template_id" {
  description = "Launch Template Id"
  type = string
}

variable "lb_target_group_arn" {
  description = "LB ARN"
  type = string
}

variable "subnet_ids" {
  description = "List of subnet IDs to launch resources in. Subnets automatically determine which availability zones the group will reside."
  type = set(string)
}