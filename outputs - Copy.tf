output "bucket_name" {
  value       = aws_s3_bucket.my_bucket.id
  description = "Name of the S3 bucket"
}