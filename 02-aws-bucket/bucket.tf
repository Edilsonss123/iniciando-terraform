resource "aws_s3_bucket" "edilson-terraform-remote-state" {
  bucket        = "edilson-terraform-remote-state"
  force_destroy = true
  tags = {
    "owner"      = "edilson"
    "managed-by" = "terraform"
  }
}