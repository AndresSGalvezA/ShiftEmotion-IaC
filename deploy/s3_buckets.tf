resource "aws_s3_bucket" "rekognition_photos" {
  bucket        = "${var.app_name}-imagesbucket-${var.id_account}"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "rekognition_photos" {
  bucket = aws_s3_bucket.rekognition_photos.id
  acl    = "private"
}
