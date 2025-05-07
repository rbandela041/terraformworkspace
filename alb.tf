resource "aws_lb" "alb" {
  name                       = "${local.vpc_name}-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.allow_all_sg.id]
  subnets                    = aws_subnet.public-subnets[*].id
  enable_deletion_protection = false

  enable_http2                     = true
  enable_cross_zone_load_balancing = true

  tags = {
    Name = "${local.vpc_name}-alb"
    Env  = local.env
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}

resource "aws_lb_target_group" "alb_target_group" {
  name     = "${local.vpc_name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc1.id

  tags = {
    Name = "${local.vpc_name}-tg"
    Env  = local.env
  }
}


resource "aws_lb_target_group_attachment" "alb_target_group_attachment" {
  count            = length(aws_instance.web_server.*.id)
  target_group_arn = aws_lb_target_group.alb_target_group.arn
  target_id        = element(aws_instance.web_server.*.id, count.index)
  port             = 80
}
