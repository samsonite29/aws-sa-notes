output "alb_sg_id" {
  description = "Application Load Balancer Security Group Id"
  value       = aws_security_group.lb_sg.id
}

output "lb_target_group" {
  description = "LB Target Group ARN"
  value = aws_lb_target_group.lb_target_group.arn
}