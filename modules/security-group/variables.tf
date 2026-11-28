variable "sg_name" {
    type = string
    description = "Security Group name"
}

variable "vpc_id" {
    type = string
    description = "VPC ID"
}

variable "ingress_cidr" {
    type = string
    description = "CIDR for IPV4"
    default =  "0.0.0.0/0"
}

variable "ingress_referenced_security_group_id" {
    type = string
    description = "Reference Security Group Id"
    default = null
}

variable "ingress_from_port" {
    type = number
    description = "Ingress from port"
    default = null
}

variable "ingress_to_port" {
    type = number
    description = "Ingress to port"
    default = null
}

variable "ingress_ip_protocol" {
    type = string
    description = "Ingress IP protocol"
    default = "tcp"
}

variable "egress_referenced_security_group_id" {
    type = string
    description = "Reference Security Group Id"
    default = null
}

variable "egress_from_port" {
    type = number
    description = "Egress from port"
    default = null
}

variable "egress_to_port" {
    type = string
    description = "Egress to port"
    default = null
}

variable "egress_ip_protocol" {
    type = string
    description = "Egress IP protocol"
    default     = "tcp"
}

variable "egress_cidr" {
    type = string
    description = "CIDR for IPV4 Egress"
    default =  "0.0.0.0/0"
}