variable "vpc_id" {
  description = "The ID of the existing VPC"
  type        = string
}

variable "internet_gateway_id" {
  description = "The ID of the existing Internet Gateway"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of existing public subnet IDs"
  type        = list(string)
}

