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

# Associate subnet with Route table
resource "aws_route_table_association" "route-table-association" {
  subnet_id = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public-route-table.id
}

#create a network interface
resource "aws_network_interface" "network-interface" {
  subnet_id = aws_subnet.public-subnet-1.id
  private_ips = ["10.0.0.50"]
  security_groups = [aws_security_group.ssh-security-group.id]
}

#create an elastic IP to the network interface 
resource "aws_eip" "eip" {
  vpc = true
  network_interface = aws_network_interface.network-interface.id
  associate_with_private_ip = "10.0.0.50"
  depends_on = [
    aws_internet_gateway.internet-gateway
  ]
}

#create ubuntu server an install apache2
resource "aws_instance" "web" {
  ami = "ami-04db49c0fb2215364"
  instance_type = "t2.micro"
  availability_zone = "ap-south-1a"
  tag = {
    Name = "Ubuntu"
  }
  key_name = "Pinal25"

  network_interface {
   device_index = 0
   network_interface_id = aws_network_interface.network-interface.id
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install apache2 -y
              sudo systemctl start apache2
              sudo bash -c "echo Your Frist Web Server" > /var/www/html/index.html
              sudo chkconfig on
              EOF
  
  tags={
    Name = "Web Server"
  }
}