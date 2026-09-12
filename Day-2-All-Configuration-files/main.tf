resource "aws_vpc" "Name" {
  cidr_block = var.cidr
  tags={
    Name = "jitu_vpc"
  }
  
}

resource "aws_subnet" "dev_subnet" {
  vpc_id = aws_vpc.Name.id
  cidr_block = "10.0.0.0/25"
}