variable "region" {
  description = "The AWS region to deploy resources"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet1_cidr" {
  description = "CIDR block for Public Subnet 1"
  default     = "10.0.1.0/24"
}

variable "public_subnet2_cidr" {
  description = "CIDR block for Public Subnet 2"
  default     = "10.0.2.0/24"
}

variable "public_subnet3_cidr" {
  description = "CIDR block for Public Subnet 3"
  default     = "10.0.3.0/24"
}



variable "availability_zones" {
  description = "Availability zones for the subnets"
  default     = ["us-east-1a", "us-east-1b","us-east-1c"]
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  default     = "ami-0e86e20dae9224db8"
}

variable "instance_type" {
  description = "The type of EC2 instance"
  default     = "t3.micro"
}

variable "security_group_cidr" {
  description = "CIDR block for security group ingress"
  default     = ["156.221.60.143/32"]
}

