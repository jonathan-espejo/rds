# -- update this configuration based on customer AWS terraform statefile configuration 
#data "terraform_remote_state" "vpc" {
#  backend = "s3"
#  config = {
#    bucket = "terraform-rds2"
#    key    = "env:/ebx-rds-dev/network.tfstate"
#    region = "ap-southeast-2"
#  }
#}
 
data "aws_ssm_parameter" "ssm" {
  name            = var.name # our SSM parameter's name
  with_decryption = true     # defaults to true, but just to be explicit...
}

data "aws_secretsmanager_secret" "passwordstore" {
  #name = local.secretname
  name = "${var.application}-rdsdb"
}

data "aws_secretsmanager_secret_version" "passwordstore" {
  secret_id = data.aws_secretsmanager_secret.passwordstore.id
}

# data for parameter group

data "terraform_remote_state" "dbparameter" {
  backend = "s3"
  config = {
    bucket = "terraform-rdsdb"
    key    = "env:/parameter-${var.application}-${var.env}/parameter.tfstate"
    region = "ap-southeast-2"
  }
}
