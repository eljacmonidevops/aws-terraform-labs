 resource "random_pet" "bucket_name" {
     length    = 2
     separator = "-"
   }

   resource "aws_s3_bucket" "website" {
     bucket = "terraform-website-${random_pet.bucket_name.id}"
     
     tags = {
       Name        = "Website Bucket"
       Environment = "Lab"
     }
   }

   resource "aws_s3_bucket_website_configuration" "website_config" {
     bucket = aws_s3_bucket.website.id

     index_document {
       suffix = "index.html"
     }

     error_document {
       key = "error.html"
     }
   }

   resource "aws_s3_bucket_public_access_block" "website_public_access" {
     bucket = aws_s3_bucket.website.id

     block_public_acls       = false
     block_public_policy     = false
     ignore_public_acls      = false
     restrict_public_buckets = false
   }

   resource "aws_s3_bucket_policy" "website_policy" {
     bucket = aws_s3_bucket.website.id
     policy = data.aws_iam_policy_document.website_policy.json
     depends_on = [aws_s3_bucket_public_access_block.website_public_access]
   }

   data "aws_iam_policy_document" "website_policy" {
     statement {
       principals {
         type        = "*"
         identifiers = ["*"]
       }
       actions = [
         "s3:GetObject"
       ]
       resources = [
         "${aws_s3_bucket.website.arn}/*"
       ]
     }
   }
   resource "aws_s3_bucket" "logs" {
     bucket = "terraform-logs-${random_pet.bucket_name.id}"
     
     tags = {
       Name        = "Logs Bucket"
       Environment = "Lab"
     }
   }

   resource "aws_s3_bucket_ownership_controls" "logs_ownership" {
     bucket = aws_s3_bucket.logs.id
     rule {
       object_ownership = "BucketOwnerPreferred"
     }
   }

   resource "aws_s3_bucket_acl" "logs_acl" {
     bucket = aws_s3_bucket.logs.id
     acl    = "private"
     depends_on = [aws_s3_bucket_ownership_controls.logs_ownership]
   }