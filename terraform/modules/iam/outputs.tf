output "glue_crawler_role_arn" {
  description = "ARN of the Glue Crawler IAM role"
  value       = aws_iam_role.glue_crawler.arn
}

output "glue_etl_job_role_arn" {
  description = "ARN of the Glue ETL Job IAM role"
  value       = aws_iam_role.glue_etl_job.arn
}

output "athena_role_arn" {
  description = "ARN of the Athena IAM role"
  value       = aws_iam_role.athena.arn
}
