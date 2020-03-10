include {
  path = "${find_in_parent_folders()}"
}
terraform {
  source = "git::ssh://git@gitlab.com/Halliburton-Landmark/dsif/terraform/aws/vpc.git//?ref=master"
}
inputs = {
  environment = "[CLUSTER_NAME]"
  owner = "platform"
  vpc_name = "[CLUSTER_NAME]"
  vpc_cidr = "10.22.0.0/16"
  vpc_private_subnet_list = ["10.22.0.0/18", "10.22.64.0/18", "10.22.128.0/18"]
  vpc_public_subnet_list = ["10.22.192.0/20", "10.22.208.0/20", "10.22.224.0/20"]
  # Domain name to be used internally
  vpc_internal_domain_name = "ec2.internal"
  dns_server_list = ["AmazonProvidedDNS"]
  tags = {Environment = "test", GithubRepo = "terraform-aws-eks", GithubOrg = "terraform-aws-modules", CreatedBy = "Jude Gonsalves", BusinessOwner = "David Clark", Project = "Phoenix", Version = "3.0"}

  aws_profile = ""
  aws_access_key = ""
  aws_secret_key = ""
  aws_assume_role = ""
  aws_region = "us-east-1"

  secondary_cidr_blocks = []
  private_hosted_zone_dns = "landmarksoftware.io"
  hosted_zone_id = "ZCY7F5HU2DCRV"
  enable_hosted_zone_association = "true"

  create_k8s_private_zone = "true"
  k8s_zone_name = "cluster.local"
}
