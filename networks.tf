resource "aws_vpc" "depi_task_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "depi_task_vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.depi_task_vpc.id
}

resource "aws_subnet" "publicSubnet1" {
  vpc_id                  = aws_vpc.depi_task_vpc.id
  cidr_block              = var.public_subnet1_cidr
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "PublicSubnet1"
  }
}

resource "aws_subnet" "publicSubnet2" {
  vpc_id                  = aws_vpc.depi_task_vpc.id
  cidr_block              = var.public_subnet2_cidr
  availability_zone       = var.availability_zones[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "PublicSubnet2"
  }
}
resource "aws_subnet" "publicSubnet3" {
  vpc_id                  = aws_vpc.depi_task_vpc.id
  cidr_block              = var.public_subnet3_cidr
  availability_zone       = var.availability_zones[2]
  map_public_ip_on_launch = true

  tags = {
    Name = "PublicSubnet3"
  }
}

resource "aws_route_table" "publicRouteTable" {
  vpc_id = aws_vpc.depi_task_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "PublicRouteTable"
  }
}

resource "aws_route_table_association" "publicSubnetAssoc1" {
  subnet_id      = aws_subnet.publicSubnet1.id
  route_table_id = aws_route_table.publicRouteTable.id
}

resource "aws_route_table_association" "publicSubnetAssoc2" {
  subnet_id      = aws_subnet.publicSubnet2.id
  route_table_id = aws_route_table.publicRouteTable.id
}

resource "aws_route_table_association" "publicSubnetAssoc3" {
  subnet_id      = aws_subnet.publicSubnet3.id
  route_table_id = aws_route_table.publicRouteTable.id
}

resource "aws_security_group" "my_sg" {
  vpc_id = aws_vpc.depi_task_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  tags = {
    Name = "MySG"
  }
}
