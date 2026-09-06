terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }

  # Remote state backend
  # the S3 bucket + DynamoDB table (see README for bootstrap steps)
  
  backend "s3" {
     bucket         = "my-terraform-state-bucket"
     key            = "3tier-app/terraform.tfstate"
     region         = "ap-south-1"
     dynamodb_table = "terraform-locks"
     encrypt        = true
   }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}
