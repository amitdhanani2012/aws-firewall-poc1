resource "aws_s3_bucket" "s3-firewall" {
  bucket = "s3-firewall"

  tags = {
    Name        = "s3-firewall"
    Environment = "amit-frewall-test"
  }
}
resource "aws_s3_bucket_ownership_controls" "s3-firewall" {
  bucket = aws_s3_bucket.s3-firewall.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "s3-firewall" {
  bucket = aws_s3_bucket.s3-firewall.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
