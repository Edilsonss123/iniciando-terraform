terraform {
  required_version = ">=1.6.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.21.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
  default_tags {
    tags = {
      "owner"      = "edilson"
      "managed-by" = "terraform"
    }
  }
}