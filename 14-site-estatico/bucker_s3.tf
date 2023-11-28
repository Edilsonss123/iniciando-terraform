resource "aws_s3_bucket" "bucket" {
  bucket        = "revbucket-${random_pet.server.id}"
  force_destroy = true
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

#policy via terraform -> https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid= "DelegateS3Access",
        Effect = "Allow"
        Principal = "*",
        "Action": [
            "s3:GetObject",
        ],
        Resource = [
          "${aws_s3_bucket.bucket.arn}/*",
          "${aws_s3_bucket.bucket.arn}",
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