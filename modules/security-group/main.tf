// Security Groups Support the following services
// EC2, RDS, Aurora, ElasticCache
// ALB and NLB
// Lambda
// EKS Nodes
// VPC Interface Endpoints, EFS, ECS

// Analogy: a guest list at the door. Ingress = who's allowed in. Once someone's in, they can leave without being checked again. Egress = whether you are allowed to go out and visit someone.


resource "aws_security_group" "this" {
    name_prefix =  "${var.sg_name}-"
    description = "Security Group for ${var.sg_name}"
    vpc_id      = var.vpc_id
    timeouts {
        delete = "5m"
    }
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_vpc_security_group_ingress_rule" "this" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4   = var.ingress_cidr
  referenced_security_group_id = var.ingress_referenced_security_group_id
  from_port   = var.ingress_from_port
  ip_protocol = var.ingress_ip_protocol
  to_port     = var.ingress_to_port
}

resource "aws_vpc_security_group_egress_rule" "this" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = var.egress_cidr
  ip_protocol       = var.egress_ip_protocol
  from_port = var.egress_from_port
  to_port = var.egress_to_port
  referenced_security_group_id = var.egress_referenced_security_group_id
}