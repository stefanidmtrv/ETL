output "database_name" {
  description = "Name of the Glue database"
  value       = aws_glue_catalog_database.etl_database.name
}

output "crawler_raw_name" {
  description = "Name of the raw zone crawler"
  value       = aws_glue_crawler.raw_zone.name
}

output "crawler_curated_name" {
  description = "Name of the curated zone crawler"
  value       = aws_glue_crawler.curated_zone.name
}

output "etl_job_name" {
  description = "Name of the Glue ETL job"
  value       = aws_glue_job.etl_job.name
}
