# Outputs for AWS ETL Pipeline Infrastructure

output "raw_bucket_name" {
  description = "Name of the S3 bucket for raw data"
  value       = module.s3_buckets.raw_bucket_name
}

output "curated_bucket_name" {
  description = "Name of the S3 bucket for curated data"
  value       = module.s3_buckets.curated_bucket_name
}

output "query_results_bucket_name" {
  description = "Name of the S3 bucket for Athena query results"
  value       = module.s3_buckets.query_results_bucket_name
}

output "glue_database_name" {
  description = "Name of the Glue database"
  value       = module.glue.database_name
}

output "glue_crawler_raw_name" {
  description = "Name of the Glue crawler for raw data"
  value       = module.glue.crawler_raw_name
}

output "glue_crawler_curated_name" {
  description = "Name of the Glue crawler for curated data"
  value       = module.glue.crawler_curated_name
}

output "glue_etl_job_name" {
  description = "Name of the Glue ETL job"
  value       = module.glue.etl_job_name
}

output "athena_workgroup_name" {
  description = "Name of the Athena workgroup"
  value       = module.athena.workgroup_name
}
