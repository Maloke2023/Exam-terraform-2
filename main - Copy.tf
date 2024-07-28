provider "aws" {
  region = var.region
}

# Variables
variable "region" {
  description = "AWS region"
  default     = "us-west-2"
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  default     = "my-unique-bucket-name-123456" # Ensure this is unique
}

variable "sns_topic_name" {
  description = "Name of the SNS topic"
  default     = "my-sns-topic"
}

# S3 Bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "My S3 Bucket"
    Environment = "Dev"
  }
}

# S3 Bucket versioning
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.my_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
###sns
#SNS Topic
resource "aws_sns_topic" "my_topic" {
  name = var.sns_topic_name
}

# CloudWatch Alarm
resource "aws_cloudwatch_metric_alarm" "s3_size_alarm" {
  alarm_name          = "s3-bucket-size-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "BucketSizeBytes"
  namespace           = "AWS/S3"
  period              = "86400"  # 24 hours
  statistic           = "Average"
  threshold           = "5000000000"  # 5 GB
  alarm_description   = "This alarm triggers when the S3 bucket size exceeds 5 GB"
  alarm_actions       = [aws_sns_topic.my_topic.arn]
}