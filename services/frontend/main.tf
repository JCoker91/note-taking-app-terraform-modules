locals {
  http_port    = 80
  any_port     = 0
  any_protocol = "-1"
  tcp_protocol = "tcp"
  all_ips      = ["0.0.0.0/0"]
}

data "terraform_remote_state" "db" {
    backend = "s3"

    config = {
        bucket = var.db_remote_state_bucket
        key = var.db_remote_state_key
        region = "us-west-2"
    }
}

data "aws_vpc" "default" {
    default = true
}

data "aws_subnets" "default" {
    filter {
        name = "vpc-id"
        values = [data.aws_vpc.default.id]
    }
}