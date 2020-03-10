#aws msk module 
#Terraform module for msk can be called using command ./config.sh <cluster name> --components msk
#
#terragrunt pointing to terraform module.
dependencies {
  paths = ["../vpc"]
}
include {
  path = "${find_in_parent_folders()}"
}
terraform {
  source = "git::ssh://git@gitlab.com/Halliburton-Landmark/dsif/terraform/aws/msk.git//?ref=master"
}

inputs = {
  #define cluster information tags
  cluster_name = "[CLUSTER_NAME]"
  engineer_name = "Akkaiah Prathipati"
  owner_name = "Wei Chiu"
  tag_business_owner = "David Clark"
  tag_version = "3.0"
  tag_project = "phoenix"
  tag_created_by = "Jude Gonsalves"
  tag_environment = "test"
  
  #define aws information
  region = "us-east-1"
  
  #define vpc,subnets and securrity groups information
  vpc_tfstate_bucket_name = "halliburton-terraform-state"
  vpc_tfstate_bucket_key = "phoenix/df14-test/.shared3/components/vpc/terraform.tfstate"
  vpc_tfstate_bucket_region = "us-east-1"
  
  #apply_immediately = "true"
  vpc_id = ""
  private_subnets = []
  allowed_security_group = [""]
  
  #define module specific variables
  kafka_version = "2.2.1"
  broker_nodes = "3"
  ebs_volume_size = "1000"
  cluster_instance_type = "kafka.m5.large"

  do_use_msk_sharedconfig = "true"
  msk_sharedconfig = "sharedconfig"
}
