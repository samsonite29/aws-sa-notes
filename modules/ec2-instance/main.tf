
resource "aws_instance" "instance" {
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  associate_public_ip_address = true
  launch_template {
    id = var.launch_template_id
    version = var.launch_template_version
  }
  tags = {
    Name = var.name
  }
}
