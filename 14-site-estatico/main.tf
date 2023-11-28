#tutorial -> https:dev.to/aws-builders/how-to-create-a-simple-static-amazon-s3-website-using-terraform-43hc
terraform {
  required_version = ">=1.6.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.21.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      "owner"      = "edilson"
      "managed-by" = "terraform"
    }
  }
}

resource "random_pet" "server" {
  length = 2
  prefix = "-"
}

 resource "aws_s3_bucket" "bucket" {
   bucket = "${var.bucket_name}" 
   force_destroy = true
 }

 data "aws_s3_bucket" "selected-bucket" {
   bucket = aws_s3_bucket.bucket.bucket
 }

 resource "aws_s3_bucket_website_configuration" "blog" {
   bucket = aws_s3_bucket.bucket.id
   index_document {
     suffix = "index.html"
   }
   error_document {
     key = "error.html"
   }
 }

 resource "aws_s3_bucket_public_access_block" "public_access_block" {
   bucket                  = aws_s3_bucket.bucket.id
   block_public_acls       = false
   block_public_policy     = false
   ignore_public_acls      = false
   restrict_public_buckets = false
 }

 resource "aws_s3_bucket_cors_configuration" "example" {
     bucket = aws_s3_bucket.bucket.bucket

   cors_rule {
     allowed_headers = ["*"]
     allowed_methods = ["PUT", "POST"]
     allowed_origins = ["https:www.${var.domain_name}"]
     expose_headers  = ["ETag"]
     max_age_seconds = 3000
   }

   cors_rule {
     allowed_methods = ["GET"]
     allowed_origins = ["*"]
   }
 }

 resource "aws_s3_bucket_policy" "bucket_policy" {
   bucket = aws_s3_bucket.bucket.id
   policy = jsonencode({
     Version = "2012-10-17"
     Statement = [
       {
         Sid= "PublicReadGetObject",
         Effect = "Allow"
         Principal = "*",
         "Action": [
             "s3:GetObject",
         ],
         Resource = [
             "arn:aws:s3:::${var.bucket_name}",
             "arn:aws:s3:::${var.bucket_name}/*",
         ]
       }
     ]
   })
 }
 resource "aws_s3_object" "upload_object" {
   for_each     = fileset("site/", "*")
   bucket       = aws_s3_bucket.bucket.id
   key          = each.value
   source       = "site/${each.value}"
   etag         = filemd5("site/${each.value}")
   content_type = "text/html"
 }

 resource "aws_route53_zone" "main" {
   name = var.domain_name
   tags = {
     Name = "www.${var.domain_name}"
     description = var.domain_name
   }
   comment = var.domain_name
 }

 resource "aws_route53_record" "www-a" {
   zone_id = aws_route53_zone.main.zone_id
   name = "www.${var.domain_name}"
   type = "A"
   alias {
     name = data.aws_s3_bucket.selected-bucket.website_endpoint
     zone_id = data.aws_s3_bucket.selected-bucket.hosted_zone_id
     evaluate_target_health = false
   }
 }