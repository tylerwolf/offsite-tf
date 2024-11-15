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

variable "workspace-number" {
  type = string
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "rocket2024-ws${var.workspace-number}-${var.team-name}"
}
