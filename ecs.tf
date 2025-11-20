resource "aws_ecs_cluster" "prodserver-mapid-cluster" {
  name = "prodserver-mapid-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "prodserver-mapid-cluster"
  }
}

resource "aws_ecs_cluster_capacity_providers" "prodserver-mapid-cluster" {
  cluster_name = aws_ecs_cluster.prodserver-mapid-cluster.name

  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

    default_capacity_provider_strategy {
        capacity_provider = "FARGATE"
        weight            = 1
        base              = 1
    }

    default_capacity_provider_strategy {
        capacity_provider = "FARGATE_SPOT"
        weight            = 2
    }
}