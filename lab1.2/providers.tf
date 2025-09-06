
   terraform {
     required_providers {
       aws = {
         source  = "hashicorp/aws"
         version = "~> 4.0"
       }
     }
   }

   provider "aws" {
     region = var.aws_region  # Change to your preferred region
   }

   # CloudFront requires a provider in us-east-1 region
   provider "aws" {
     alias  = "us_east_1"
     region = "us-east-1"
   }