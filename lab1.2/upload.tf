 resource "aws_s3_object" "html_files" {
     for_each = fileset("${path.module}/website-files", "*.html")
     
     bucket       = aws_s3_bucket.website.id
     key          = each.value
     source       = "${path.module}/website-files/${each.value}"
     content_type = "text/html"
     etag         = filemd5("${path.module}/website-files/${each.value}")
   }