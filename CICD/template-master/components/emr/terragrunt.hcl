dependencies {
  paths = ["../vpc", "../iam"]
}
include {
  path = "${find_in_parent_folders()}"
}
terraform {
  source = "git::ssh://git@gitlab.com/Halliburton-Landmark/dsif/terraform/aws/emr.git//?ref=master"
}

inputs = {
  cluster_name = "[CLUSTER_NAME]"
  engineer_name = "Jude Gonsalves"
  business_owner = "David Clark"
  project_version = "3.0"
  createdby = "Jude Gonsalves"
  core_instance_count = 3
  region = "us-east-1"
  az_index = "2"
  dsif_emr_bucket = "null"
  emr_ec2_instance_profile_arn = "null"
  emr_service_role_arn = "null"
  emr_autoscaling_role_arn = "null"
  project_name = "PhoenixDistplatform"
  environment = "development"
  key_pair_name = "null"
  public_key_path = "~/.ssh/id_rsa.pub"
  key_name = "emr-phoenix-cluster-key"
  max_task_instances_count = 300
  ebs_volume_size = 1050
  emr_version = "emr-5.28.0"
  private_ssh_key_ssm_path = "phoenix-dev-key"
  #master_instance_type = "c4.8xlarge"
  #core_instance_type = "c4.8xlarge"
  master_instance_type = "m4.xlarge"
  core_instance_type = "m4.xlarge"
  instancegroup1_ebs_volume_size = 256
  instancegroup1_min_task_instances_count = 2
  instancegroup1_max_task_instances_count = 20
  #task_instance_group1_type = "c4.8xlarge"
  #task_instance_group2_type = "c4.8xlarge"
  #task_instance_group3_type = "c5.9xlarge"
  #task_instance_group4_type = "c5.18xlarge"
  task_instance_group1_type = "m4.xlarge"
  task_instance_group2_type = "m4.xlarge"
  task_instance_group3_type = "m4.xlarge"
  task_instance_group4_type = "m4.xlarge"
  vpc_tfstate_bucket_key = "phoenix/df14-test/.shared3/components/vpc/terraform.tfstate"
  vpc_tfstate_bucket_name = "halliburton-terraform-state"
  vpc_tfstate_bucket_region = "us-east-1"
  do_use_prereqs_tfstate = "true"
  prereqs_tfstate_bucket_key = "phoenix/df14-test/.dev/components/prereqs/terraform.tfstate"
  prereqs_tfstate_bucket_name = "halliburton-terraform-state"
  prereqs_tfstate_bucket_region = "us-east-1"
  do_use_iam_tfstate = "true"
  iam_tfstate_bucket_key = "phoenix/df14-test/.shared3/components/iam/terraform.tfstate"
  iam_tfstate_bucket_name = "halliburton-terraform-state"
  iam_tfstate_bucket_region = "us-east-1"
  applications = ["Spark", "JupyterHub", "Hadoop", "Livy", "Hue", "Hive", "Ganglia"]
  k8s_zone_name = ""
  k8s_zone_id = ""
}
