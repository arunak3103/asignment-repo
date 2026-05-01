resource "aws_lb" "test_alb" {
  name = "test-alb"
  load_balancer_type = "application"
  security_groups = [var.alb_sg]
  subnets = var.subnet_ids

}
resource "aws_lb_target_group" "tg" {
  name = "app-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    path = "/"
    port = "80"
  }
}

resource "aws_lb_target_group_attachment" "attach" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id = var.target_instance_id
  port = 80
}

resource "aws_lb_listener" "listen" {
  load_balancer_arn = aws_lb.test_alb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}
