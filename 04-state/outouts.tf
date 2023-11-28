output "bucket_id" {
  description = "Id da bucket criada na AWS"
  value       = aws_s3_bucket.terraform-state-bucket-ed.id
}

output "bucket_arn" {
  description = "ARM da bucket criada na AWS"
  value       = aws_s3_bucket.terraform-state-bucket-ed.arn
}