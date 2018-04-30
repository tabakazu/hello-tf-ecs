# Provider
provider "aws" {
  region = "${var.region}"
}


# VPC
resource "aws_vpc" "01" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
}


# Internet G/W
resource "aws_internet_gateway" "01" {
  vpc_id = "${aws_vpc.01.id}"
}


# VPC Subnet
resource "aws_subnet" "public-1a" {
  vpc_id            = "${aws_vpc.01.id}"
  availability_zone = "${var.az["a"]}"
  cidr_block        = "10.0.0.0/24"
}

resource "aws_subnet" "public-1c" {
  vpc_id            = "${aws_vpc.01.id}"
  availability_zone = "${var.az["c"]}"
  cidr_block        = "10.0.1.0/24"
}


# VPC RouteTable
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.01.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.01.id}"
  }
}

resource "aws_route_table_association" "public-1a" {
  subnet_id      = "${aws_subnet.public-1a.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "public-1c" {
  subnet_id      = "${aws_subnet.public-1c.id}"
  route_table_id = "${aws_route_table.public.id}"
}


# SecurityGroup
resource "aws_security_group" "alb" {
  name        = "alb"
  vpc_id      = "${aws_vpc.01.id}"

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ec2" {
  name        = "ec2"
  vpc_id      = "${aws_vpc.01.id}"

  ingress {
    protocol        = "-1"
    from_port       = 0
    to_port         = 0
    security_groups = ["${aws_security_group.alb.id}"]
  }
    
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}