resource "aws_lb" "nlb" {
  name               = var.name
  internal           = false
  load_balancer_type = "network"
  security_groups    = [aws_security_group.nlb_sg.id]
  subnets            = var.subnet_ids
  ip_address_type    = "ipv4"
}


resource "aws_security_group" "nlb_sg" {
  name_prefix = "${var.name}-nlb-"
  description = "Security Group for NLB"
  vpc_id      = var.vpc_id
  timeouts {
    delete = "10m"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_ingress_rule" "http_ingress" {
  security_group_id = aws_security_group.nlb_sg.id
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}


resource "aws_vpc_security_group_egress_rule" "http_egress" {
  security_group_id = aws_security_group.nlb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}


resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = 80
  protocol   = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_target_group.arn
  }
}


resource "aws_lb_target_group" "nlb_target_group" {
  name_prefix = "${substr(var.name, 0, 5)}-"
  port     = 80
  protocol = "TCP"
  vpc_id   = var.vpc_id
  target_type = "instance"
  health_check {
    enabled             = true
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_lb_target_group_attachment" "web_instance" {
  
  for_each = var.instance_ids
  target_group_arn = aws_lb_target_group.nlb_target_group.arn
  target_id        = each.value
  port             = 80
}
