terraform {
    backend "s3"{
        bucket = "terraform-rdsdb"
        key = "parameter.tfstate"
        dynamodb_table = "terraform-lock-table-rds"
        region = "ap-southeast-2"
        acl = "bucket-owner-read"
    }
}
