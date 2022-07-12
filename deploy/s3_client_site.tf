resource "aws_s3_bucket" "client_website" {
  bucket        = "${var.app_name}-client-website-${var.id_account}"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "client_website" {
  bucket = aws_s3_bucket.client_website.id
  acl    = "public-read"
}

// AWS IAM data for S3 bucket's website policy
data "aws_iam_policy_document" "client_website_s3" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion"
    ]
    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
    resources = [
      "${aws_s3_bucket.client_website.arn}/*"
    ]
  }
}

resource "aws_s3_bucket_policy" "client_website" {
  bucket = aws_s3_bucket.client_website.id
  policy = data.aws_iam_policy_document.client_website_s3.json
}

resource "aws_s3_bucket_website_configuration" "client_website" {
  bucket = aws_s3_bucket.client_website.bucket
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "index.html"
  }
}
