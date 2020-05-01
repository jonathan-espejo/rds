variable "db_engine" {
  description = "Database engine used e.g. postgres, mqsql"
  default     = "postgres"
}

variable "db_allocated_storage" {
  description = "The allocated storage in GB"
  type = number
}

variable "db_max_allocated_storage" {
  description = "The max allocated storage in GB"
  type = number
}

variable "db_instance_class" {
  description = "The instance type of the RDS instance"
}

variable "db_iops" {
  description = "provisioned IOPS, value iss greater than 0 if storage_type is i01"
}

variable "db_engine_version" {
  description = "The engine version to use e.g. 10"
  default     = "10.11"
}

variable "db_storage_type" {
  description = "The disk type is gp2 or io1"
  default     = "gp2"
}

variable "db_backup_retention_period" {
  description = "The days to retain backups. Must be 1 or greater to be a source for a Read Replica"
  default     = "7"
}

variable "db_port" {
  description = "Port number database listens"
  default     = 5432
  type        = number
}

variable "db_name" {
  description = "The name of the default database to be created on the instance"
  default     = "postgres"
}

variable "db_user_name" {
  description = "RDS postgres super user instance owner"
  default     = "postgres"
}

variable "db_password" {
  description = "RDS postgres super user password"
  default     = "passw0rd"
}

variable "allow_major_version_upgrade" {
  description = "Indicates that major version upgrades are allowed."
  default     = "false"
}

# variable "force_ssl" {
#   description = "Enforce SSL connections, set to true to enable"
#   default     = "true"
# }

variable "db_rds_family" {
  description = "Postgres version family, i.e. postgres10 for version family, postgres11 for version 11 family"
  default     = "postgres10"
}

variable "name" {
  description = "Resource name"
  default     = "postgres-instance"
}

variable "application" {
  description = "Application name which will use this instance"
}

variable "env" {
  description = "RDS postgres environment i.e nonprd or prod"
}

variable "managed" {
  description = "Resource managed by terraform"
  default     = "terraform"
}

variable "multi_az" {
  description = "true if multi-az configuration"
}
