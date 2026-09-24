resource "aws_vpc" "main" {
  cidr_block = "10.37.0.0/16"

  tags = {
    Name = "k8s-lab-vpc-tatiana"
  }
}

resource "aws_subnet" "control_plane" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.37.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "k8s-lab-subnet-cp-tatiana"
  }
}

resource "aws_subnet" "workers" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.37.2.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "k8s-lab-subnet-workers-tatiana"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "k8s-lab-igw-tatiana"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "k8s-lab-public-rt-tatiana"
  }
}

resource "aws_route_table_association" "control_plane" {
  subnet_id      = aws_subnet.control_plane.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "workers" {
  subnet_id      = aws_subnet.workers.id
  route_table_id = aws_route_table.public.id
}
