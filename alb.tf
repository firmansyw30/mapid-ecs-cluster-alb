resource "aws_lb" "prodserver-alb-mapid" {
  name               = "prodserver-alb-mapid"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_sg.id]
  subnets            = data.aws_subnets.existing.ids

  enable_deletion_protection = true

  tags = {
    Environment = "production"
    Name        = "prodserver-alb-mapid"
  }
}


#   load_balancer_arn = aws_lb.prodserver-alb-mapid.arn
#   port              = "443"
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = "arn:aws:acm:ap-southeast-3:392987323540:certificate/985cbd3a-f6c7-40c1-afd4-c91d768bfc91"

#   default_action {
#     type             = "forward"
#     //target_group_arn = aws_lb_target_group.prodserver-alb-mapid.arn
#   }
# }