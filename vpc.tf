locals {
  region = data.aws_region.current.name
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "msk-vpc"
  cidr = "10.0.0.0/16"

  azs = [
    data.aws_availability_zones.azs.names[0],
    data.aws_availability_zones.azs.names[1],
    data.aws_availability_zones.azs.names[2]
  ]

  private_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]

  enable_ipv6 = true

  vpc_tags = {
    Name = "msk-vpc"
  }

}
