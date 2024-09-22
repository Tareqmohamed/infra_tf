 resource "aws_lb_target_group" "lb_tg" {
   name     = "learn-asg-depi"
   port     = 80
   protocol = "HTTP"
   vpc_id   = aws_vpc.depi_task_vpc.id
 }
 resource "aws_lb" "lb" {
  name               = "learn-asg-depi-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.my_sg.id]
  subnets            = [aws_subnet.publicSubnet1.id,aws_subnet.publicSubnet2.id,aws_subnet.publicSubnet3.id]
}
resource "aws_lb_listener" "terramino" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_tg.arn
  }
}


resource "aws_autoscaling_attachment" "asa" {
    lb_target_group_arn = aws_lb_target_group.lb_tg.arn
    autoscaling_group_name = aws_autoscaling_group.asc.name
}
