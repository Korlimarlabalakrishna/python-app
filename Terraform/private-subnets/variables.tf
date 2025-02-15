variable "vpc_id" {
  description = "Existing VPC ID"
  type        = string
}

variable "subnet_cidrs" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
}

variable "azs" {
  description = "List of Availability Zones"
  type        = list(string)
}

variable "subnet_name_prefix" {
  description = "Prefix for private subnet names"
  type        = string
}

