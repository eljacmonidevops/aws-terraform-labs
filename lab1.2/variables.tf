variable "aws_region" {
    description = "AWS region to create resources in"
    type        = string
    default     = "us-east-1"
}

variable "bucket_name" {
    description = "Unique S3 bucket name for the website (must be globally unique)"
    type        = string
    default     = "tf-website-example-123456789" # change to a unique name
}