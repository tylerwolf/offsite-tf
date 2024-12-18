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

variable "tfc_vault_backed_aws_dynamic_credentials" {
  description = "Object containing Vault-backed AWS dynamic credentials configuration"
  type = object({
    default = object({
      shared_credentials_file = string
    })
    aliases = map(object({
      shared_credentials_file = string
    }))
  })
}


provider "aws" {
  region = "us-west-2"
  alias = "WEST"
  shared_credentials_files = [var.tfc_vault_backed_aws_dynamic_credentials.aliases["WEST"].shared_credentials_file]
}

provider "aws" {
  region = "us-east-2"
  alias = "EAST"
  shared_credentials_files = [var.tfc_vault_backed_aws_dynamic_credentials.aliases["EAST"].shared_credentials_file]
}

resource "aws_s3_bucket" "bucket-west" {
  bucket = "rocket-offsite2024-${var.team-name}-ws${var.workspace-number}-west"
  provider = aws.WEST
}

resource "aws_s3_bucket" "bucket-east" {
  bucket = "rocket-offsite2024-${var.team-name}-ws${var.workspace-number}-east"
  provider = aws.EAST
}
