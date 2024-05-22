terraform {
  required_version = "~>1.5"

  backend "s3" {
    bucket         = "poc-tf-ecs-ec2"
    key            = "tf-infra/terraform.tfstate"
    region         = "eu-west-3"
    dynamodb_table = "pocTfEcsEc2"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

module "tf-state" {
  source      = "./modules/tf-state"
  bucket_name = local.bucket_name
  table_name  = local.table_name
}

module "ecrRepo" {
  source = "./modules/ecr"

  ecr_repo_name = local.ecr_repo_name
}