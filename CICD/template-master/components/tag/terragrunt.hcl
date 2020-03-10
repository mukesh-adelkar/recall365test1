include {
  path = "${find_in_parent_folders()}"
}
terraform {
  source = "git::ssh://git@gitlab.com/Halliburton-Landmark/dsif/terraform/aws/tag.git//?ref=master"
}
inputs = {
  region           = "us-east-1"
  environment      = "[CLUSTER_NAME]"
  owner            = "Wei Chiu"
  engineer_name    = "Jude Gonsalves"
  cluster_name     = "[CLUSTER_NAME]"
  resource_name    = "[CLUSTER_NAME]"
  business_owner   = "David Clark"
  project          = "[CLUSTER_NAME]"
  platform_version = "3.6.0"
  crfid            = "CRF000[CLUSTER_NAME]"
}
