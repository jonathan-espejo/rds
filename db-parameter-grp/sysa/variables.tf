variable "db_rds_family" {
  description = "Postgres version family, i.e. postgres10 for version family, postgres11 for version 11 family"   
  default     = "postgres10"
}
variable "application" { }

variable "env" { }
