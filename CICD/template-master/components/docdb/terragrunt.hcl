dependencies {
  paths = ["../vpc"]
}
include {
  path = "${find_in_parent_folders()}"
}
terraform {
  source = "git::ssh://git@gitlab.com/Halliburton-Landmark/dsif/terraform/aws/documentdb.git//?ref=master"
}

inputs = {
  vpc_tfstate_bucket_name   = "halliburton-terraform-state"
  vpc_tfstate_bucket_key    = "phoenix/df14-test/.shared3/components/vpc/terraform.tfstate"
  vpc_tfstate_bucket_region = "us-east-1"

  do_use_prereqs_tfstate = "true"
  prereqs_tfstate_bucket_key = "phoenix/df14-test/.dev/components/prereqs/terraform.tfstate"
  prereqs_tfstate_bucket_name = "halliburton-terraform-state"
  prereqs_tfstate_bucket_region = "us-east-1"

  region = "us-east-1"

  vpc_id = "null"

  docdb_username_param_name = "null"
  docdb_password_param_name = "null"

  cluster_identifier     = "[CLUSTER_NAME]-docdb"
  instance_count         = "1"
  private_ssh_key_ssm_path = "phoenix-dev-key"

  private_subnets = []
}
