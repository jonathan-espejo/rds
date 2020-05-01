resource "aws_db_parameter_group" "rds_parameter" {
  name   = "${var.application}-${var.env}-rds-parameter"
  family = "postgres10"
  parameter {
    name         = "application_name"
    value        = var.application
    apply_method = "immediate"
  }
  parameter {
    name         = "deadlock_timeout"
    value        = 15
  }
  parameter {
    name         = "autovacuum"
    value        = 0
  }
  parameter {
    name         = "autovacuum_naptime"
    value        = 10
  }
  parameter {
    name         = "work_mem"
    value        = 1024
  }
  parameter {
    name         = "max_connections"
    value        = 50
    apply_method = "pending-reboot"
  }

  tags = {
    Name = "${var.application}-${var.env}-rds-paremeter"
  }
}

