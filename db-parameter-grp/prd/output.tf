# Output the ID of the RDS instance parameter group

output "rds_parameter_group_id" {
  value = aws_db_parameter_group.rds_parameter.id
}
