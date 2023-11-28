variable "location" {
  description = "Região onde os recursos serão criados na Azure"
  type        = string
  default     = "West Europe"
}

variable "account_tier" {
  description = "Tier da Storage Account na Azure"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Tipo de replicação de dados da Storage Account"
  type        = string
  default     = "LRS"
}

variable "resource_group_name" {
  type        = string
  description = "Nome para o Resource Group na Azure"
  default     = "rgcursocerraform"
}

variable "storage_account_name" {
  type        = string
  description = "Nome da Storage Account na Azure"
  default     = "rgcursocerraform"
}

variable "container_name" {
  type        = string
  description = "Nome do Container na Azure"
  default     = "containerterraform"
}