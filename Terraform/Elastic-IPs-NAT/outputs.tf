output "elastic_ips" {
  value = aws_eip.nat_eip[*].public_ip
}

