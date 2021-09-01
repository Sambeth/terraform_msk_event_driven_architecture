resource "aws_vpc" "vpc" {
  cidr_block = "192.168.0.0/22"
}

resource "aws_subnet" "subnet_az1" {
  cidr_block        = "192.168.0.0/24"
  vpc_id            = aws_vpc.vpc.id
  availability_zone = data.aws_availability_zones.azs.names[0]
}

resource "aws_subnet" "subnet_az2" {
  cidr_block        = "192.168.1.0/24"
  vpc_id            = aws_vpc.vpc.id
  availability_zone = data.aws_availability_zones.azs.names[1]
}

resource "aws_subnet" "subnet_az3" {
  cidr_block        = "192.168.2.0/24"
  vpc_id            = aws_vpc.vpc.id
  availability_zone = data.aws_availability_zones.azs.names[2]
}

resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.vpc.id
}
