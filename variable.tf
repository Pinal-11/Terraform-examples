variable "region" {
  default = "ap-south-1"
  description = "aws region"
  type = string
}

variable "vpc-cidr" {
  default = "10.0.0.0/16"
  description = "vpc cidr block"
  type = string
}

variable "multi-az-deployment" {
  default     = false
  description = "create a standby db instance"
  type        = bool
}

variable "endpoint-email" {
  default     = "add your email address"
  description = "valid email address"
  type        = string
}

variable "public-subnet-1-cidr" {
  default     = "10.0.1.0/24"
  description = "public subnet 1 cidr block"
  type        = string
}

variable "public-subnet-2-cidr" {
  default     = "10.0.2.0/24"
  description = "public subnet 2 cidr block"
  type        = string
}

variable "private-subnet-1-cidr" {
  default     = "10.0.3.0/24"
  description = "private subnet 1 cidr block"
  type        = string
}

variable "private-subnet-2-cidr" {
  default     = "10.0.4.0/24"
  description = "private subnet 2 cidr block"
  type        = string
}

variable "ssl-certificate-arn" {
  default     = "add your certificate arn"
  description = "ssl Certificate arn"
  type        = string
}

variable "ssh-locaation" {
  default     = "0.0.0.0/0"
  description = "IP Address that can ssh into the ec2 instances"
  type        = string
}
