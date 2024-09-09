resource "aws_networkfirewall_logging_configuration" "aws-firewall-log-s31" {
  firewall_arn = aws_networkfirewall_firewall.aws-firewall1.arn
  logging_configuration {
    log_destination_config {
      log_destination = {
        bucketName = aws_s3_bucket.s3-firewall.bucket
        prefix     = "/aws-firewall-log1"
      }
      log_destination_type = "S3"
      log_type             = "FLOW"
    }
  }
}

resource "aws_networkfirewall_logging_configuration" "aws-firewall-log-s32" {
  firewall_arn = aws_networkfirewall_firewall.aws-firewall2.arn
  logging_configuration {
    log_destination_config {
      log_destination = {
        bucketName = aws_s3_bucket.s3-firewall.bucket
        prefix     = "/aws-firewall-log2"
      }
      log_destination_type = "S3"
      log_type             = "FLOW"
    }
  }
}

