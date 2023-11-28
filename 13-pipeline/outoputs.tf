output "vm_aws" {
  description = "Ip da máquina virtul criada na AWS"
  value       = aws_instance.vm.public_ip
}

output "security_group_id" {
  description = "ID da Security Group criada na AWS"
  value       = aws_security_group.security_group.id
}