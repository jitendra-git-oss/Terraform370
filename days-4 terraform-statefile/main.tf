resource "aws_vpc" "name" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "vpc_tag"
  }
}


resource "aws_subnet" "dev" {
  vpc_id     = aws_vpc.name.id
  cidr_block = var.subnet_cidr
  tags = {
    Name = "subnet_tag"
  }
}

resource "aws_instance" "web" {
  ami                    = "ami-098f18a6382fb4b2d"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.dev.id

}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name-jitu-s3"
}