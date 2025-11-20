data "aws_vpc" "existing" {
  filter {
    name   = "tag:Name"
    values = ["jakarta_VPC"]
  }
}

# Get subnets within the VPC
data "aws_subnets" "existing" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing.id]
  }
}