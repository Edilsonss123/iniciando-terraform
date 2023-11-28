resource "aws_s3_bucket" "bucket-terraform-edilson" {
  bucket = "bucket-${var.enviroment}"
  count = var.enviroment == "dev" ? 0: 1
    
  tags = {
    "owner"      = "edilson"
    "managed-by" = "terraform"
  }
}