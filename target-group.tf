# Target Groups
resource "aws_lb_target_group" "prod-geoserver-nodejs-tg" {
    name        = "prod-geoserver-nodejs-tg"
    port        = 4004
    protocol    = "HTTP"
    target_type = "ip"
    vpc_id      = data.aws_vpc.existing.id

    health_check {
        enabled             = true
        healthy_threshold   = 3
        interval           = 30
        matcher            = "200"
        path               = "/license/server_status"
        port               = "traffic-port"
        protocol           = "HTTP"
        timeout            = 5
        unhealthy_threshold = 3
    }

    tags = {
        Name = "prod-geoserver-nodejs-tg"
    }
}

resource "aws_lb_target_group" "prod-geoserver-bunjs-tg" {
    name        = "prod-geoserver-bunjs-tg"
    port        = 4005
    protocol    = "HTTP"
    target_type = "ip"
    vpc_id      = data.aws_vpc.existing.id

    health_check {
        enabled             = true
        healthy_threshold   = 3
        interval           = 30
        matcher            = "200"
        path               = "/auth_bun/server_status"
        port               = "traffic-port"
        protocol           = "HTTP"
        timeout            = 5
        unhealthy_threshold = 3
    }

    tags = {
        Name = "prod-geoserver-bunjs-tg"
    }
}

resource "aws_lb_target_group" "prod-geoserver-nodejs-rf-tg" {
    name        = "prod-geoserver-nodejs-rf-tg"
    port        = 4006
    protocol    = "HTTP"
    target_type = "ip"
    vpc_id      = data.aws_vpc.existing.id

    health_check {
        enabled             = true
        healthy_threshold   = 3
        interval           = 30
        matcher            = "200"
        path               = "/mobile"
        port               = "traffic-port"
        protocol           = "HTTP"
        timeout            = 5
        unhealthy_threshold = 3
    }

    tags = {
        Name = "prod-geoserver-nodejs-rf-tg"
    }
}

# HTTP to HTTPS redirect listener
resource "aws_lb_listener" "prodserver-http-listener" {
    load_balancer_arn = aws_lb.prodserver-alb-mapid.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
        type = "redirect"

        redirect {
            port        = "443"
            protocol    = "HTTPS"
            status_code = "HTTP_301"
            host        = "#{host}"
            path        = "/#{path}"
            query       = "#{query}"
        }
    }
}

# HTTPS listener
resource "aws_lb_listener" "prodserver-https-listener" {
    load_balancer_arn = aws_lb.prodserver-alb-mapid.arn
    port              = "443"
    protocol          = "HTTPS"
    ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-Res-2021-06"
    certificate_arn   = "arn:aws:acm:ap-southeast-3:392987323540:certificate/985cbd3a-f6c7-40c1-afd4-c91d768bfc91"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.prod-geoserver-nodejs-tg.arn
    }
}

# Listener Rule 1
resource "aws_lb_listener_rule" "prod-geoserver-bunjs-listener" {
    listener_arn = aws_lb_listener.prodserver-https-listener.arn
    priority     = 1

    action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.prod-geoserver-bunjs-tg.arn
    }

    condition {
        path_pattern {
            values = ["/auth_bun/*", "/moneys_bun/*", "/sini_v2/*", "/sheets/*", "/mapid_ai/*"]
        }
    }

    tags = {
        Name = "prod-geoserver-bunjs-listener"
    }
}

# Listener Rule 2
resource "aws_lb_listener_rule" "prod-geoserver-nodejs-rf-listener-1" {
    listener_arn = aws_lb_listener.prodserver-https-listener.arn
    priority     = 2

    action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.prod-geoserver-nodejs-rf-tg.arn
    }

    condition {
        path_pattern {
            values = ["/mobile/*", "/admin_mobile/*", "/events/*", "/maluku/*", "/blog_ai/*"]
        }
    }

    tags = {
        Name = "prod-geoserver-nodejs-rf-listener"
    }
}

# Listener Rule 3
resource "aws_lb_listener_rule" "prod-geoserver-nodejs-rf-listener-2" {
    listener_arn = aws_lb_listener.prodserver-https-listener.arn
    priority     = 3

    action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.prod-geoserver-nodejs-rf-tg.arn
    }

    condition {
        path_pattern {
            values = ["/blog_ai/*", "/basemap/*", "/gps/*", "/academy/*"]
        }
    }

    tags = {
        Name = "prod-geoserver-nodejs-rf-listener"
    }
}