variable "aws_key_pub" {
  type        = string
  description = "Chave pública para a máquina AWS"
}

variable "region" {
  type        = string
  description = "Região provisionamento do recurso"
  default     = "eu-central-1"
}