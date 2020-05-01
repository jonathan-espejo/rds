# locals {
#   description = "Name of RDS postgres instance"
#   identifier  = "rdm-nonprd-instance"
# }

locals {
  secret_postgres_value = jsondecode(data.aws_secretsmanager_secret_version.passwordstore.secret_string)["postgres"]
}

resource "aws_db_instance" "rds_instance" {
  identifier                          = "${var.application}-${var.env}-instance"
  engine                              = var.db_engine
  allocated_storage                   = var.db_allocated_storage
  max_allocated_storage               = var.db_max_allocated_storage
  instance_class                      = var.db_instance_class
  engine_version                      = var.db_engine_version
  storage_type                        = var.db_storage_type 			          # storage_type is eithe gp2 (ssd) or io1
  port                                = var.db_port
  maintenance_window                  = "Sat:17:00-Sat:18:00" 			        # time set in UTC equals to Sydney 03:00-04:00 
  backup_window                       = "15:00-15:30"         			        # time set in UTC equals to Sydney 02:00-02:30
  backup_retention_period             = var.db_backup_retention_period
  name                                = var.db_name
  username                            = var.db_user_name
  password                            = data.aws_ssm_parameter.ssm.value   	# ssm parameter store
  #password                           = local.secret_postgres_value 		    # aws secrets manager
  #password                           = var.db_password 			              # default password - change password after initial install
  allow_major_version_upgrade         = var.allow_major_version_upgrade
  vpc_security_group_ids              = [aws_security_group.rds_sg.id]
  db_subnet_group_name                = aws_db_subnet_group.rds_subnet_group.name
  parameter_group_name                = data.terraform_remote_state.dbparameter.outputs.rds_parameter_group_id
  #parameter_group_name                = aws_db_parameter_group.rds_parameter.name
  multi_az                            = var.multi_az
  deletion_protection                 = false
  enabled_cloudwatch_logs_exports     = ["postgresql"]
  auto_minor_version_upgrade          = false
  publicly_accessible                 = false
  skip_final_snapshot                 = true
  tags = {
    name        = "${var.application}-${var.env}-${var.name}"
    application = var.application
    env         = var.env
    managed     = var.managed
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "${var.application}-${var.env}-rds-postgres-subnet"
  description = "Allowed subnets for Postgres DB cluster instances"
  #subnet_ids  = ["${data.terraform_remote_state.vpc.outputs.private_subnet_1}", "${data.terraform_remote_state.vpc.outputs.private_subnet_2}"]
  #subnet_ids =  var.env == "prd" ? local.prd_subnet : local.nonprd_subnet
  subnet_ids    = ["subnet-02d649d1aee84f403","subnet-0ed0d87b6da126bff"]
  tags = {
    Name = "${var.application}-${var.env}-subnet-group"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "${var.application}-${var.env}-rds-sg"
  description = "Allow traffic for rds "
  #vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
  vpc_id        = "vpc-09747e6fdcb2c7cb5"  # hard-coded, need to fix data.statefile issue

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.61.124.0/24"]
    #cidr_blocks = ["10.0.0.0/8"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.application}-${var.env}-rds-sg"
  }

}

resource "aws_route53_record" "route53_cname" {
  zone_id = "Z0770098JJ5CCWVJK842"     #--modify this based from customer AWS network configuration
  #zone_id = data.terraform_remote_state.vpc.outputs.zone-id     #--modify this based from customer AWS network configuration
  name    = "${var.application}-${var.env}"
  type    = "CNAME"
  ttl     = 30
  records = [aws_db_instance.rds_instance.address] 
}
