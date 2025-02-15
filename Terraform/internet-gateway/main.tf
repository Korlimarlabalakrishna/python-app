provider "aws" {
  region = "us-east-2" # Change to your AWS region
}

resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "python-app-igw"
  }
}

