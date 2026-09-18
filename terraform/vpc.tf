resource "aws_vpc" "devops_mini" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "devops-mini-vpc"
  }
}

resource "aws_subnet" "devops_mini_public_1" {
  vpc_id            = aws_vpc.devops_mini.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-north-1a"

  tags = {
    Name = "devops-mini-public-subnet-1"
  }
}

resource "aws_subnet" "devops_mini_private_1" {
  vpc_id            = aws_vpc.devops_mini.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-north-1a"

  tags = {
    Name = "devops-mini-private-subnet-1"
  }
}

resource "aws_subnet" "devops_mini_public_2" {
  vpc_id            = aws_vpc.devops_mini.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-north-1b"

  tags = {
    Name = "devops-mini-public-subnet-2"
  }
}

resource "aws_subnet" "devops_mini_private_2" {
  vpc_id            = aws_vpc.devops_mini.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "eu-north-1b"

  tags = {
    Name = "devops-mini-private-subnet-2"
  }
}

resource "aws_internet_gateway" "devops_mini" {
  vpc_id = aws_vpc.devops_mini.id

  tags = {
    Name = "devops-mini-igw"
  }
}

resource "aws_route_table" "devops_mini_public" {
  vpc_id = aws_vpc.devops_mini.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devops_mini.id
  }

  tags = {
    Name = "devops-mini-public-rt"
  }
}

resource "aws_route_table_association" "devops_mini_public" {
  subnet_id      = aws_subnet.devops_mini_public_1.id
  route_table_id = aws_route_table.devops_mini_public.id
}

resource "aws_route_table_association" "devops_mini_public_2" {
  subnet_id      = aws_subnet.devops_mini_public_2.id
  route_table_id = aws_route_table.devops_mini_public.id
}

resource "aws_eip" "devops_mini_nat" {
  domain = "vpc"

  tags = {
    Name = "devops-mini-nat-eip"
  }
}

resource "aws_nat_gateway" "devops_mini" {
  allocation_id = aws_eip.devops_mini_nat.id
  subnet_id     = aws_subnet.devops_mini_public_1.id

  tags = {
    Name = "devops-mini-nat"
  }

  depends_on = [
    aws_internet_gateway.devops_mini
  ]
}

resource "aws_route_table" "devops_mini_private" {
  vpc_id = aws_vpc.devops_mini.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.devops_mini.id
  }

  tags = {
    Name = "devops-mini-private-rt"
  }
}

resource "aws_route_table_association" "devops_mini_private_1" {
  subnet_id      = aws_subnet.devops_mini_private_1.id
  route_table_id = aws_route_table.devops_mini_private.id
}

resource "aws_route_table_association" "devops_mini_private_2" {
  subnet_id      = aws_subnet.devops_mini_private_2.id
  route_table_id = aws_route_table.devops_mini_private.id
}