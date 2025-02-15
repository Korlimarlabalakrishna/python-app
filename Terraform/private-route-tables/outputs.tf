output "private_route_table_ids" {
  description = "IDs of the created private route tables"
  value       = aws_route_table.private[*].id
}

