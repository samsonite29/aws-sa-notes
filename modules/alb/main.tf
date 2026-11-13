
################ Traffic Flow for an application load balancer ################ 

# Client makes requests → internet-facing ALB → HTTP listener on port  80 → target group → healthy EC2 instance Alpha or  Beta → response back through the ALB → client


# Two Separate connection 

# Client ↔ ALB: HTTP over TCP port 80
# ALB ↔ EC2 instance: HTTP over TCP port 80


# 1. The client reaches the ALB

# 2. The ALB security group checks whether traffic is allowed


// Your ingress rule allows TCP port 80 from 0.0.0.0/0, so any IPv4 client can attempt an HTTP connection.

// The security group is a security filter, not a separate forwarding hop. It permits or blocks traffic reaching the ALB.


# 3. The listener receives the HTTP request

// aws_lb_listener.lb_listener should listen on HTTP port 80.

// Its default action forwards requests to target group

//  Because you have only a default forwarding action and no additional listener rules, every accepted HTTP request goes to that same target group. There is no path-based or hostname-based routing yet.

# 4. The target group identifies eligible EC2 instances

# Your target group uses:

# Protocol: HTTP
# Port: 80
# Target type: instance


# The target group is a configuration and target registry—not another server that traffic physically passes through. The ALB uses that configuration to select a target and establish a backend connection.

# With instance targets, it sends traffic to the selected instance primary private IP address on port 80.

# 5. The ALB forwards the request to Alpha or Beta

# With the default round-robin routing algorithm, the ALB distributes requests among eligible healthy targets.

# For example:

# Request 1 → Alpha:80
# Request 2 → Beta:80


# 6. The instance responds through the ALB

# The selected instance processes the request and returns its response to the ALB. The ALB then sends that response back over its connection to the client.
data "aws_caller_identity" "current" {}

# S3 bucket for Application Load Balancer logs 

resource "aws_s3_bucket" "lb_logs" {
  bucket = "${var.name}-lb-logs-${data.aws_caller_identity.current.account_id}"
}

# Policy to ALB push logs to S3

resource "aws_s3_bucket_policy" "allow_lb_logging" {
  bucket = aws_s3_bucket.lb_logs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowALBLogDelivery"
        Effect = "Allow"
        Principal = {
          Service = "logdelivery.elasticloadbalancing.amazonaws.com"
        }
        Action = "s3:PutObject"
        Resource = [
          "${aws_s3_bucket.lb_logs.arn}/access-logs/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
          "${aws_s3_bucket.lb_logs.arn}/connection-logs/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
          "${aws_s3_bucket.lb_logs.arn}/health-check-logs/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
        ]
      }
    ]
  })
}


# Security group just for the load balancer to allow inbound traffic from anywhere

resource "aws_security_group" "lb_sg" {
  name_prefix = "${var.name}-alb-"
  description = "Allow web inbound traffic"
  vpc_id      = var.vpc_id
  timeouts {
    delete = "5m"
  }

  lifecycle {
    create_before_destroy = true
  }
}


# Ingress rule for security group  which allows only HTTP request 
resource "aws_vpc_security_group_ingress_rule" "http_ingress" {
  security_group_id = aws_security_group.lb_sg.id
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

# Egress rule for security group  which allows only HTTP request 
resource "aws_vpc_security_group_egress_rule" "http_egress" {
  security_group_id = aws_security_group.lb_sg.id
  // allow ALB → instances (anything in instance_sg_id) on 80
  referenced_security_group_id   =  var.instance_sg_id
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}



# Target group and Health check

resource "aws_lb_target_group" "lb_target_group" {
  name_prefix = "${substr(var.name, 0, 5)}-"
  port     = 80
  protocol = "HTTP"
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


# Attach Instances to target group
resource "aws_lb_target_group_attachment" "web_instance" {
  for_each = {
    alpha = var.alpha_instance_id
    beta  = var.beta_instance_id
  }

  target_group_arn = aws_lb_target_group.lb_target_group.arn
  target_id        = each.value
  port             = 80
}


resource "aws_lb" "app_lb" {
  name               = var.name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = var.subnet_ids
  ip_address_type    = "ipv4"
  drop_invalid_header_fields = true

# Monitoring the ALBS

  # Tracks Application Traffic
   access_logs {
    bucket  = aws_s3_bucket.lb_logs.id
    prefix  = "access-logs"
    enabled = true
  }

  # Tracks the following example  connection lifecycle, TLS connections(HTTPS listener) and handshake details
  connection_logs {
    bucket  = aws_s3_bucket.lb_logs.id
    prefix  = "connection-logs"
    enabled = true
  }

  # target group health_check block configures the checks. This configures only destination of the logs

  health_check_logs {
    bucket  = aws_s3_bucket.lb_logs.id
    prefix  = "health-check-logs"
    enabled = true
  }

  depends_on = [
    aws_s3_bucket_policy.allow_lb_logging
  ]
}

# Listener to target

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}


