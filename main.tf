resource "aws_vpc" "test1vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "test1vpc"
  }
}

resource "aws_subnet" "test1subnet" {
  vpc_id     = aws_vpc.test1vpc.id
  cidr_block = var.subnet_cidr
  availability_zone = "ap-south-1a"
  tags = {
    Name = "test1subnet"
  }
}

resource "aws_internet_gateway" "test1igw" {
  vpc_id = aws_vpc.test1vpc.id
  tags = {
    Name = "test1igw"
  }
}

resource "aws_route_table" "test1rt" {
  vpc_id = aws_vpc.test1vpc.id
  route {
    cidr_block = var.vpc_cidr
    gateway_id = aws_internet_gateway.test1igw.id
  }
  tags = {
    Name = "test1rt"
  }
}
resource "aws_route_table_association" "test1rta" {
  subnet_id      = aws_subnet.test1subnet.id
  route_table_id = aws_route_table.test1rt.id
}

resource "aws_security_group" "test1sg" {
  name        = "test1sg"
  description = "Security group for test1"
  vpc_id      = aws_vpc.test1vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
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
}
resource "aws_instance" "test1instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.test1subnet.id
  security_groups = [aws_security_group.test1sg.id]
  key_name = var.key-pair
}