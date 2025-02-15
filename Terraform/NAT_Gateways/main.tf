provider "aws" {
  region = "us-east-2"
}

# Allocate Elastic IPs for NAT Gateways
resource "aws_eip" "nat_eip" {
  count = length(var.public_subnet_ids)
  domain = "vpc"
}

# Create NAT Gateways
resource "aws_nat_gateway" "nat_gw" {
  count         = length(var.public_subnet_ids)
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = var.public_subnet_ids[count.index]

  tags = {
    Name = "nat-gateway-${count.index + 1}"
  }

  depends_on = [aws_eip.nat_eip]
}

