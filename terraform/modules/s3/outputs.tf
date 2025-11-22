output "raw_bucket_name" {
  description = "Name of the raw zone bucket"
  value       = aws_s3_bucket.raw.id
}

output "raw_bucket_arn" {
  description = "ARN of the raw zone bucket"
  value       = aws_s3_bucket.raw.arn
}

output "curated_bucket_name" {
  description = "Name of the curated zone bucket"
  value       = aws_s3_bucket.curated.id
}

output "curated_bucket_arn" {
  description = "ARN of the curated zone bucket"
  value       = aws_s3_bucket.curated.arn
}

output "query_results_bucket_name" {
  description = "Name of the query results bucket"
  value       = aws_s3_bucket.query_results.id
}

output "query_results_bucket_arn" {
  description = "ARN of the query results bucket"
  value       = aws_s3_bucket.query_results.arn
}
