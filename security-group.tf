# create Security Group for the Application Load Balancer
# terraform aws ctrate security group
resource "aws_security_group" "alb-security-group" {
  name        = "ALB Security Group"
  description = "Enable http/https access on port 80/443"
  vpc_id      = aws_vpc.vpc.id


ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "http Access"
    cidr_blocks = ["0.0.0.0/0"]
  }

ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    description = "http Access"
    cidr_blocks = ["0.0.0.0/0"]
  }

egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ALB Security Group "
  }
}

#Create Security Group for the bastion host aka jump box
# terraform aws creeatw security group
resource "aws_security_group" "ssh-security-group" {
  name        = "SSH Security Group"
  description = "Enable SSH access on port 22"
  vpc_id      = aws_vpc.vpc.id

  ingress = {
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH Access"
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }

  egress = {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0 
  } 

  tags = {
    Name = "SSH Security Group"
  }
}

#Create security group with firewall rules
resource "aws_security_group" "security_jenkins_port" {
  name        = "security_jenkins_port"
  description = "security group for jenkins"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 # outbound from jenkis server
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags= {
    Name = "security_jenkins_port"
  }
}


