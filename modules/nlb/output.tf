output "nlb_sg_id" {
  description = "Network Load Balancer Security Group Id"
  value       = aws_security_group.nlb_sg.id
}