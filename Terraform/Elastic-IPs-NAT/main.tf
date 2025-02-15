provider "aws" {
  region = "us-east-2" 
}

# Create 3 Elastic IPs for NAT Gateways
resource "aws_eip" "nat_eip" {
  count  = 3
  domain = "vpc"

  tags = {
    Name = "nat-eip-${count.index + 1}"
  }
}

