# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc-cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    name = "VPC"
  }
}

# Create Internet Gateway and attach it to vpc
resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "IGW"
  }
}

#create public subnet 1
resource "aws_subnet" "public-subnet-1" {
  vpc_id                          = aws_vpc.vpc.id
  cidr_block                      = var.public-subnet-1-cidr
  availability_zone               = "ap-south-1a"
  map_customer_owned_ip_on_launch = true

  tags = {
    Name = "Public subnet 1"
  }
}

#Create public subnet 2
resource "aws_subnet" "public-subnet-2" {
  vpc_id                          = aws_vpc.vpc.id
  cidr_block                      = var.public-subnet-2-cidr
  availability_zone               = "ap-south-1b"
  map_customer_owned_ip_on_launch = true

  tags = {
    Name = "Public subnet 2"
  }
}

# Create Route Table and Add public Route
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc.id

  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }

  tags = {
    Name = "Public route table"
  }

}
