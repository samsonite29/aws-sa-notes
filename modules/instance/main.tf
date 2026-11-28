
resource "aws_instance" "instance" {
  launch_template {
    id = var.launch_template_id
    version = var.launch_template_version
  }
  tags = {
    Name = var.name
  }
}
