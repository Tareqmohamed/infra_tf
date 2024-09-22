resource "aws_launch_configuration" "lc" {
    name_prefix     = "depi-terraform-aws-asg-"
    image_id = var.ami_id
    instance_type = var.instance_type
    security_groups = [aws_security_group.my_sg.id]
    user_data = file("userdata.sh")
    lifecycle {
        create_before_destroy = true
    }
    
}
resource "aws_autoscaling_group" "asc" {
    desired_capacity   = 1
    max_size           = 3
    min_size           = 1
    vpc_zone_identifier = [
        aws_subnet.publicSubnet1.id,
        aws_subnet.publicSubnet2.id,
        aws_subnet.publicSubnet3.id
    ]
    launch_configuration = aws_launch_configuration.lc.name
    tag {
        key                 = "Name"
        value               = "ASG"
        propagate_at_launch = true
    }
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "terramino_scale_down"
  autoscaling_group_name = aws_autoscaling_group.asc.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 120
}

resource "aws_cloudwatch_metric_alarm" "scale_down" {
  alarm_description   = "Monitors CPU utilization for Terramino ASG"
  alarm_actions       = [aws_autoscaling_policy.scale_down.arn]
  alarm_name          = "terramino_scale_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  threshold           = "10"
  evaluation_periods  = "2"
  period              = "120"
  statistic           = "Average"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asc.name
  }
}
