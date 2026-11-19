data "aws_ami" "image" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }
}


resource "aws_launch_template" "instance_template" {
  name = var.template_name

  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size = 1
      delete_on_termination = true
    }
  }

  image_id = data.aws_ami.image.id
  instance_type = "t3.micro"
  user_data = base64encode(var.user_data)
}
