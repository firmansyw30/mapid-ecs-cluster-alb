output "alb_arn" {
    description = "The ARN (Amazon Resource Name) of the Application Load Balancer"
    value       = aws_lb.prodserver-alb-mapid.arn
}

output "alb_dns_name" {
    description = "The DNS name of the Application Load Balancer"
    value       = aws_lb.prodserver-alb-mapid.dns_name
}

output "alb_zone_id" {
    description = "The hosted zone ID of the Application Load Balancer"
    value       = aws_lb.prodserver-alb-mapid.zone_id
}

output "target_group_arn" {
    description = "The ARN of the Target Group for Geoserver and NodeJS"
    value       = aws_lb_target_group.prod-geoserver-nodejs-tg.arn
}

output "ecs_cluster_name" {
    description = "The name of the ECS cluster"
    value       = aws_ecs_cluster.prodserver-mapid-cluster.name
}

output "alb_security_group_id" {
    description = "The ID of the security group attached to the ALB"
    value       = aws_security_group.web_sg.id
}