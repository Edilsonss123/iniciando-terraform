variable "cidr_vpc" {
  description = "Cidr para a VPC criada na AWS"
  type        = string
}

variable "cidr_subnet" {
  description = "Cidr para a Subnet criada na AWS"
  type        = string
}

variable "environment" {
  description = "Ambiente a que pertecem o modulo"
  type        = string
}