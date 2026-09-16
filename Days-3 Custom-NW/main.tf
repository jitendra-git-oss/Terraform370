#vpc Creation 
resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "custom-vpc"
  }
}


resource "aws_subnet" "subnet-1" {
  vpc_id     = aws_vpc.name.id
  cidr_block = var.subnet_cidr
  tags = {
    Name = "custom-subnet-1"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.name.id
  tags = {
    Name = "custom-igw"

  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.name.id
  tags = {
    Name = "custom-rt"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}


resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "sg" {
  name        = "custom-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.name.id

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

resource "aws_instance" "web" {
  ami                    = "ami-098f18a6382fb4b2d"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.subnet-1.id
  vpc_security_group_ids = [aws_security_group.sg.id]
}

