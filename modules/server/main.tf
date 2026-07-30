data "aws_ami" "image" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "architecture"
    values = ["arm64"]
  }
  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }
}

resource "aws_instance" "instance"{
    ami = aws_ami.image.id
    instance_type = var.instance_type
    user_data = var.user_data
}