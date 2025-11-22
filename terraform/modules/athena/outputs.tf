output "workgroup_name" {
  description = "Name of the Athena workgroup"
  value       = aws_athena_workgroup.etl_workgroup.name
}

output "workgroup_id" {
  description = "ID of the Athena workgroup"
  value       = aws_athena_workgroup.etl_workgroup.id
}
