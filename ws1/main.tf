terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

variable "team-name" {
  type = string
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "rocket2024-ws1-${var.team-name}"
  acl = "public-read"
}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.bucket.id
  key = "file"
  content_base64 = "TGVnZW5kcyBvZiB0aGUgSGlkZGVuIFRlbXBsZSB3YXMgcmVjb3JkZWQgaW4gZnJvbnQgb2YgYSBsaXZlIHN0dWRpbyBhdWRpZW5jZSBpbiBOaWNrZWxvZGVvbiBTdHVkaW9zIGF0IFVuaXZlcnNhbCBTdHVkaW9zLCBGbG9yaWRhLg=="
}
