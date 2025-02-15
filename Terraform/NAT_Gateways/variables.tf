variable "public_subnet_ids" {
  type    = list(string)
  default = [
    "subnet-0bca33b41d5744671",
    "subnet-0322ca058a3cb2a26",
    "subnet-09c09e48fd2caeffb"
  ] # Replace with your actual public subnet IDs
}

