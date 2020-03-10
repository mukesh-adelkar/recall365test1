dependencies {
  paths = ["../vpc"]
}
include {
  path = "${find_in_parent_folders()}"
}
terraform {
  source = "git::ssh://git@gitlab.com/Halliburton-Landmark/dsif/terraform/aws/aurora.git//?ref=master"
} 

inputs = {
  cluster_name = "[CLUSTER_NAME]"
  engineer_name = "Jude Gonsalves"
  owner_name = "Wei Chiu"

  business_owner = "David Clark"
  version = "3.0"
  project = "phoenix"
  owner = "Wei Chiu"
  createdby = "Jude Gonsalves"

  region = "us-east-1"

  vpc_tfstate_bucket_name = "halliburton-terraform-state"
  vpc_tfstate_bucket_key = "phoenix/df14-test/.shared3/components/vpc/terraform.tfstate"
  vpc_tfstate_bucket_region = "us-east-1"
  #tag_tfstate_bucket_name = "halliburton-terraform-state"
  #tag_tfstate_bucket_key = "phoenix/df14-test/.shared3/components/tag/terraform.tfstate"
  #tag_tfstate_bucket_region = "us-east-1"


  cluster_instance_type = "db.r4.large"
  gis_cluster_instance_type = "db.r4.large"
  db_engine = "aurora-postgresql"
  engine_version = "9.6.8"
  replica_count = 1
  storage_encrypted = "true"
  apply_immediately = "true"
  monitoring_interval = 10
  #master_username = "master"
  #master_password = "master_password123"
  aurora_master_username_ssm_path = "/rd/dev/phoenix/support/aurora_master_username"
  aurora_master_password_ssm_path = "/rd/dev/phoenix/support/aurora_master_password"
  skip_final_snapshot = "true"

  #vpc_id = "vpc-046973fab6fcd3304"
  #private_subnets = ["subnet-01facee34558c01e4", "subnet-09f10bde6a8364b9e"]
}
