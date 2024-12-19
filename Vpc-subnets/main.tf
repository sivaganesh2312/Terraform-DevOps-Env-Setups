resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "terraform"
      Env = "Dev"
      Project = "Learning"
    } 
}

resource "aws_subnet" "one" {
    vpc_id = aws_vpc.my_vpc.id
    availability_zone = "ap-south-1a"
    cidr_block = "10.0.0.0/24"
    tags = {
      Name = "web-1"
      Env = "Dev"
      Project = "Learning"
    }
}

resource "aws_subnet" "two" {
    vpc_id = aws_vpc.my_vpc.id
    availability_zone = "ap-south-1b"
    cidr_block = "10.0.1.0/24"
    tags = {
      Name = "web-2"
      Env= "Dev"
      Project="Learning"
    }
}

