resource "aws_autoscaling_group" "autoscaling_group" {
  name = var.name
  desired_capacity   = var.desired_capacity
  max_size           = var.max_capacity
  min_size           = 1
  health_check_type         = "ELB"

  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }

  vpc_zone_identifier = var.subnet_ids

}


resource "aws_autoscaling_attachment" "autoscaling_attachment" {
  autoscaling_group_name = aws_autoscaling_group.autoscaling_group.id
  lb_target_group_arn    = var.lb_target_group_arn
}

