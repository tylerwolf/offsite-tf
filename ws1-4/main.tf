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
  bucket = "rocket-offsite2024-${var.team-name}-ws${var.workspace-number}"
}
