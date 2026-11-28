
resource "aws_instance" "instance" {
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  launch_template {
    id = var.launch_template_id
    version = var.launch_template_version
  }
  tags = {
    Name = var.name
  }
}
