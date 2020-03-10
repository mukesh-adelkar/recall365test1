dependencies {
  paths = ["../vpc"]
}
include {
  path = "${find_in_parent_folders()}"
}
terraform {
  source = "git::ssh://git@gitlab.com/Halliburton-Landmark/dsif/terraform/aws/efs.git//?ref=master"
} 

inputs = {
  name = "[CLUSTER_NAME]"

  enabled             = "true"
  namespace           = ""
  stage               = ""
# eks_security_groups = ["sg-0c730351822a25982"]
  vpc_id              = "vpc-0e5a58882974f1c64"
  region              = "us-east-1"
# private_subnets     = ["subnet-0a493534b8db9b373", "subnet-067c807ef7ea52145"]
  availability_zones  = ["us-east-1a", "us-east-1b"]
  delimiter           = "-"
  attributes          = []
  
  tags = {Environment = "test", CreatedBy = "Jude Gonsalves", BusinessOwner = "David Clark", Project = "Phoenix", Version = "3.0"}
  
  encrypted                       = "true"
  performance_mode                = "generalPurpose"
  provisioned_throughput_in_mibps = 0
  throughput_mode                 = "bursting"
  mount_target_ip_address         = ""
  k8s_zone_name                   = ""
  k8s_zone_id                     = ""

  vpc_tfstate_bucket_name   = "halliburton-terraform-state"
  vpc_tfstate_bucket_key    = "phoenix/df14-test/.shared3/components/vpc/terraform.tfstate"
  vpc_tfstate_bucket_region = "us-east-1"
}
