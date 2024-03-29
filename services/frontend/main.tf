terraform {
    backend "s3" {
        bucket = var.remote_state_bucket
        key    = var.remote_state_key
        region = var.region
        dynamodb_table = "nta-locks"
        encrypt = true
    }
}

locals {
  http_port    = 80
  any_port     = 0
  any_protocol = "-1"
  tcp_protocol = "tcp"
  all_ips      = ["0.0.0.0/0"]
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