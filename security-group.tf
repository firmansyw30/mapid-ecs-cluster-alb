# Security Group 1 - Allow HTTP/HTTPS from anywhere
resource "aws_security_group" "web_sg" {
    name        = "web_sg"
    description = "Allow HTTP/HTTPS inbound traffic and all outbound traffic for prod server mapid"
    vpc_id      = data.aws_vpc.existing.id

    tags = {
        Name = "web_sg"
    }
}

# HTTP ingress rules
resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
    security_group_id = aws_security_group.web_sg.id
    cidr_ipv4        = "0.0.0.0/0"
    from_port        = 80
    ip_protocol      = "tcp"
    to_port          = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv6" {
    security_group_id = aws_security_group.web_sg.id
    cidr_ipv6        = "::/0"
    from_port        = 80
    ip_protocol      = "tcp"
    to_port          = 80
}

# HTTPS ingress rules
resource "aws_vpc_security_group_ingress_rule" "allow_https_ipv4" {
    security_group_id = aws_security_group.web_sg.id
    cidr_ipv4        = "0.0.0.0/0"
    from_port        = 443
    ip_protocol      = "tcp"
    to_port          = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_ipv6" {
    security_group_id = aws_security_group.web_sg.id
    cidr_ipv6        = "::/0"
    from_port        = 443
    ip_protocol      = "tcp"
    to_port          = 443
}

# Security Group 2 - Allow specific ports from SG
resource "aws_security_group" "prodserver-ecs-task-sg-mapid" {
    name        = "prodserver-ecs-task-sg-mapid"
    description = "Allow inbound traffic on ports 4004-4006 from web_sg"
    vpc_id      = data.aws_vpc.existing.id

    tags = {
        Name = "prodserver-ecs-task-sg-mapid"
    }
}

# Port 4004-4006 ingress rules from SG
resource "aws_vpc_security_group_ingress_rule" "allow_4004" {
    security_group_id            = aws_security_group.prodserver-ecs-task-sg-mapid.id
    referenced_security_group_id = aws_security_group.web_sg.id
    from_port                   = 4004
    ip_protocol                 = "tcp"
    to_port                     = 4004
}

resource "aws_vpc_security_group_ingress_rule" "allow_4005" {
    security_group_id            = aws_security_group.prodserver-ecs-task-sg-mapid.id
    referenced_security_group_id = aws_security_group.web_sg.id
    from_port                   = 4005
    ip_protocol                 = "tcp"
    to_port                     = 4005
}

resource "aws_vpc_security_group_ingress_rule" "allow_4006" {
    security_group_id            = aws_security_group.prodserver-ecs-task-sg-mapid.id
    referenced_security_group_id = aws_security_group.web_sg.id
    from_port                   = 4006
    ip_protocol                 = "tcp"
    to_port                     = 4006
}

# Egress rules for both security groups
resource "aws_vpc_security_group_egress_rule" "web_sg_egress_ipv4" {
    security_group_id = aws_security_group.web_sg.id
    cidr_ipv4        = "0.0.0.0/0"
    ip_protocol      = "-1"
}

resource "aws_vpc_security_group_egress_rule" "web_sg_egress_ipv6" {
    security_group_id = aws_security_group.web_sg.id
    cidr_ipv6        = "::/0"
    ip_protocol      = "-1"
}

resource "aws_vpc_security_group_egress_rule" "prodserver-ecs-task-sg-mapid_egress_ipv4" {
    security_group_id = aws_security_group.prodserver-ecs-task-sg-mapid.id
    cidr_ipv4        = "0.0.0.0/0"
    ip_protocol      = "-1"
}

resource "aws_vpc_security_group_egress_rule" "prodserver-ecs-task-sg-mapid_egress_ipv6" {
    security_group_id = aws_security_group.prodserver-ecs-task-sg-mapid.id
    cidr_ipv6        = "::/0"
    ip_protocol      = "-1"
}