output "alb_sg_id" {
  description = "Application Load Balancer Security Group Id"
  value       = aws_security_group.lb_sg.id
}