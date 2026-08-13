resource "aws_vpc" "test1vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "test1vpc"
  }
  
}
resource "aws_subnet" "test1subnet" {
  vpc_id     = aws_vpc.test1vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "test1subnet"
  }
}