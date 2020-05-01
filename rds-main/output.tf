# Output the ID of the RDS instance
output "rds_instance_id" {
  value = aws_db_instance.rds_instance.id
}

# Output the address (aka hostname) of the RDS instance
output "rds_instance_address" {
  value = aws_db_instance.rds_instance.address
}

# Output endpoint (hostname:port) of the RDS instance
output "rds_instance_endpoint" {
  value = aws_db_instance.rds_instance.endpoint
}

# Output endpoint (hostname:port) of the RDS instance
output "rds_instance_allocated_storage" {
  value = aws_db_instance.rds_instance.allocated_storage
}

# Output the ID of the Subnet Group
output "subnet_group_id" {
  value = aws_db_subnet_group.rds_subnet_group.id
}

# Output DB security group ID
output "security_group_id" {
  value = aws_security_group.rds_sg.id
}

#output "rds_route53_cname" {
#  value = aws_route53_record.rdm_cname.name
#}
