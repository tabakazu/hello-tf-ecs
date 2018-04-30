# ALB
resource "aws_lb" "web" {
  name               = "taba-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.alb.id}"]
  subnets            = ["${aws_subnet.public-1a.id}","${aws_subnet.public-1c.id}"]
}


# ALB Target Group
resource "aws_lb_target_group" "web" {
  name     = "taba-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.01.id}"
}


# ALB Listener
resource "aws_lb_listener" "web" {
  load_balancer_arn = "${aws_lb.web.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.web.arn}"
    type             = "forward"
  }
}