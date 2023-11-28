resource "aws_s3_bucket" "bucket" {
  bucket = "edilson-remote-state"
}

resource "aws_s3_bucket_versioning" "edilson-state-versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}