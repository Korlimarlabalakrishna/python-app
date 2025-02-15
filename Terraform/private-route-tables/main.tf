# Create 3 private route tables for the existing VPC
resource "aws_route_table" "private" {
  count  = 3
  vpc_id = var.vpc_id

  tags = {
    Name = "private-route-table-${count.index + 1}"
  }
}

# Associate route tables with private subnets
resource "aws_route_table_association" "private" {
  count          = 3
  subnet_id      = var.private_subnet_ids[count.index]
  route_table_id = aws_route_table.private[count.index].id
}

