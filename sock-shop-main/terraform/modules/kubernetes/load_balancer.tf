# resource "aws_acm_certificate" "site_cert" {
#   domain_name       = var.domain_name
#   validation_method = "DNS"
# }

resource "aws_lb" "ci-sockshop-k8s-elb" {
  name               = var.lb_name
  load_balancer_type = "application"
  subnets            = var.public_subnets
  security_groups    = [module.eks.cluster_security_group_id]
}

resource "aws_lb_target_group" "ci-sockshop-k8s-tg" {
  name     = var.lb_tg_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group" "ci-sockshop-k8s-https-tg" {
  name     = "${var.lb_tg_name}-https"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = var.vpc_id

  target_type = "ip"

  health_check {
    path                = "/"
    protocol            = "HTTPS"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.ci-sockshop-k8s-elb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ci-sockshop-k8s-tg.arn
  }
}

resource "aws_lb_listener" "zipkin" {
  load_balancer_arn = aws_lb.ci-sockshop-k8s-elb.arn
  port              = 9411
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ci-sockshop-k8s-tg.arn
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.ci-sockshop-k8s-elb.arn
  port              = 443
  protocol          = "HTTPS"

  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:eu-west-3:484497069811:certificate/9302641e-61f1-4e80-b4d1-582fb5c96400"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ci-sockshop-k8s-https-tg.arn
  }
}

# resource "aws_lb_listener" "https" {
#   load_balancer_arn = aws_lb.ci-sockshop-k8s-elb.arn
#   port              = 443
#   protocol          = "HTTPS"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.ci-sockshop-k8s-tg.arn
#   }
# }
