dependencies {
  paths = ["../vpc", "../aurora", "../efs", "../emr", "../msk", "../iam", "../docdb"] # "../cassandra"
}
include {
  path = "${find_in_parent_folders()}"
}
terraform {
  source = "git::ssh://git@gitlab.com/Halliburton-Landmark/dsif/terraform/aws/eks.git//?ref=master"
}

inputs = {
  cluster_name = "[CLUSTER_NAME]"
  engineer_name = "Jude Gonsalves"

  optional_name_suffix = ""
  
  aws_acm_arn = ""
  #aws_acm_arn = "arn:aws:acm:us-east-1:099253701690:certificate/77ce1bae-7378-4542-832d-a20d150d1223"
  
  enable_public_api_server = "true"
  enable_private_api_server = "false"

  
  environment      = "rd-prod-distplat"
  # env_crf_id needs to be changed for the customer cluster to be billed appropriately
  env_crf_id       = "CRFTEST"
  business_owner   = "David Clark"
  platform_version = "3.0"
  project          = "phoenix"
  owner            = "Wei Chiu"
  createdby        = "Jude Gonsalves"
  tag_factory      = "rd"
  tag_phase        = "dev"
  tag_type         = "infrastructure"
  tag_assigned_to  = "rdinfrastructure"

  dpcli_tag        = "latest"
  
  #### OEC has an existing key in EC2, can we refer to via SSM Paramstore lookup?
  key_name = "oecbackend"
  ### Currently eks module fails looking for a cluster_public_key.pub file in the phoenix module
  
  additional_userdata = ""
  plat_system_env = "[PATH_TO_EKS_FILES]/components/eks/config/plat-spec-config.yaml"
  
  bastion_ami = "ami-0be0f32d7704f6a49"
  bastion_do_associate_ip_address = "true"
  bastion_instance_type = "t2.medium"
  
  worker_ami_id = "ami-0c5cc79fe1d92b0a5"
  gpu_ami_id = "ami-0c5cc79fe1d92b0a5"

  cassandra_endpoint = "cassandra.us-east-1.amazonaws.com"
  cassandra_port = "9142"
  
  aurora_cluster_tfstate_bucket_key = "phoenix/df14-test/[CLUSTER_NAME]/components/aurora/terraform.tfstate"
  aurora_cluster_tfstate_bucket_name = "halliburton-terraform-state"
  aurora_cluster_tfstate_bucket_region = "us-east-1"
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
  do_use_efs_tfstate = "true"
  efs_tfstate_bucket_key = "phoenix/df14-test/.shared3/components/efs/terraform.tfstate"
  efs_tfstate_bucket_name = "halliburton-terraform-state"
  efs_tfstate_bucket_region = "us-east-1"
  do_use_emr_tfstate = "true"
  emr_tfstate_bucket_key = "phoenix/df14-test/.shared3/components/emr/terraform.tfstate"
  emr_tfstate_bucket_name = "halliburton-terraform-state"
  emr_tfstate_bucket_region = "us-east-1"
  do_use_msk_tfstate = "true"
  msk_cluster_tfstate_bucket_key = "phoenix/df14-test/.shared3/components/msk/terraform.tfstate"
  msk_cluster_tfstate_bucket_name = "halliburton-terraform-state"
  msk_cluster_tfstate_bucket_region = "us-east-1"
  do_use_docdb_tfstate = "true"
  docdb_tfstate_bucket_key = "phoenix/df14-test/.shared3/components/docdb/terraform.tfstate"
  docdb_tfstate_bucket_name = "halliburton-terraform-state"
  docdb_tfstate_bucket_region = "us-east-1"
  do_use_cassandra_tfstate = "false"
  cassandra_tfstate_bucket_key = "phoenix/df14-test/.shared3/components/cassandra/terraform.tfstate"
  cassandra_tfstate_bucket_name = "halliburton-terraform-state"
  cassandra_tfstate_bucket_region = "us-east-1"
  do_use_rancher_agent = "false"
  rancher_server = "rancher.distop2.landmarksoftware.io"
  rancher_agent_yaml_file = ""
  influxdb_name = "influxdb-dev.ienergycloud.io"
  influxdb_db = "prometheus"
  influxdb_user = "telegraf"
  
  region = "us-east-1"
  terraform_operation = "create"
  
  do_drop_database = "true"
  worknode_type = "m4.2xlarge"
  tests_execution = "False"
  desired_instances_count = "2"
  do_install_autoscaler = "false"
  min_instances_count = "2"
  max_instances_count = "10"
  min_instances_gpu_count = "0"
  max_instances_gpu_count = "0"
  desired_instances_gpu_count = "0"
  gpu_worknode_type = "p2.xlarge"
  gpu_worknode_labels = "landmark=gpu"
  gpu_worknode_taints = "gpu=true:NoSchedule"
  min_instances_mo_count = "1"
  max_instances_mo_count = "2"
  desired_instances_mo_count = "1"
  mo_worknode_type = "r5.2xlarge"
  mo_worknode_labels = "landmark=bigmemory"
  mo_worknode_taints = "bigmemory=true:NoSchedule"
  dns = "landmarksoftware.io"
  hosted_zone_id = "ZCY7F5HU2DCRV"
  hosted_zone_domain = "landmarksoftware.io"
  ######## What are these values in DF-18?  ###############
  filebeat_companyname = "Landmark"
  logstash_entrypoint = "logstash-test.ienergycloud.io:5044"
  efs_server = ""
  efs_filesystem = ""
  efs_security_group = ""
  ##########################################################
  map_users = [{
    userarn  = "arn:aws:iam::099253701690:user/dummy"
    username = "dummy"
    groups   = ["distplat:devs"]
  }]
  pre_userdata = <<EOF
touch /tmp/pre_userdata
EOF
  aws_profile="default"
  worker_group_count = "2"
  do_use_https = "true"
  domain = "landmarksoftware.io"
  cert_test_hosted_zone_id = "ZWUUYUBJMC8YE"
  record_type = "CNAME"
  record_ttl = "300"
  validation_method = "DNS"
  subdomain_prefixes = ["*.[CLUSTER_NAME]", "[CLUSTER_NAME]", "*.[CLUSTER_NAME]-admin", "[CLUSTER_NAME]-admin"]
  
  
  #vpc_id = "vpc-0e5a58882974f1c64"
  #private_subnets = ["subnet-0a493534b8db9b373", "subnet-067c807ef7ea52145"]
  #public_subnets = ["subnet-078f36e5322e76790", "subnet-07a1d1f7bfcc9f6ec"]
  #bastion_subnet = "subnet-04678f57e2e6d3edd"
  #aurora_cluster_endpoint = "phoenix.cluster-c4pn6sqzp7fq.us-east-1.rds.amazonaws.com"
  #aurora_cluster_master_password = "bUVjfxsa0C8Mhw"
  #aurora_cluster_sg_id = "sg-03afb759886168370"
  
  do_create_bastion_role = "false"
  cluster_version = "1.14"
  logstash_hostname = "logstash-secure.ienergycloud.io:5044"

  emr_slave_security_group_id = "null"
  emr_master_security_group_id = "null"
  emr_master_ip_address = "null"
  emr_master_public_dns = "null"
  emr_cluster_name = "null"
  emr_s3_bucket = "null"

  key_pair_name = "null"
  private_ssh_key_ssm_path = "null"
  dsif_eks_bucket = "null"
  dsif_emr_bucket = "null"
  dsif_jupyter_bucket = "null"

  cluster_role_name = "null"
  workers_role_name = "null"
  worker_iam_instance_profile_name = "null"
  bastion_role_name = "null"
  bastion_role_arn = "null"
  bastion_instance_profile_name = "null"
  cassandra_username = "null"
  cassandra_password = "null"

  ienergy_docker_registry_user_param_name = "null"
  ienergy_docker_registry_pwd_param_name = "null"
  keycloak_username_param_name = "null"
  keycloak_password_param_name = "null"
  crypto_key_param_name = "null"
  docdb_username_param_name = "null"
  docdb_password_param_name = "null"
  postgresql_username_param_name = "null"
  postgresql_password_param_name = "null"
  grafana_username_param_name = "null"
  grafana_password_param_name = "null"
  dsis_username_param_name = "null"
  dsis_password_param_name = "null"
  newrelic_accountid_param_name = "null"
  newrelic_insert_key_param_name = "null"
  newrelic_query_key_param_name = "null"
  newrelic_license_key_param_name = "null"

  vpc_id = "null"
  private_subnets = []
  public_subnets = []
  default_vpc_security_group_id = "null"
  nat_public_ip_address = "null"

  cassandra_agent_ip_addresses = []
  cassandra_security_group_id = "null"

  aurora_cluster_id = "null"
  aurora_cluster_endpoint = "null"
  aurora_cluster_master_username = "null"
  aurora_cluster_master_password = "null"
  aurora_cluster_sg_id = "null"

  efs_server = "null"
  efs_filesystem = "null"
  efs_security_group = "null"

  docdb_cluster_id = "null"
  docdb_hostname = "null"
  docdb_security_group_id = "null"

  msk_cluster_brokers_list = "null"
  msk_cluster_sg_id = "null"
  
  k8s_zone_name = ""
  k8s_zone_id = ""

  production_stage = "false"
  do_create_internal_admin_lb =""
  
  do_create_record_sets = "true"
  extra_istio_ingress_cidr_ranges = []

  amazon_digital_certificate_url = "https://www.amazontrust.com/repository/AmazonRootCA1.pem"
}
