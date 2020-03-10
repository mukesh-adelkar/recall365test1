variable "region" {
}

variable "vpc_id" {
  default = ""
}

variable "private_subnets" {
  type = list(string)

  default = []
}

#variable "azs" { type = "list" }
#variable "do_reference_vpc_workspace" {}
#variable "vpc_workspace_name" {}
variable "vpc_tfstate_bucket_name" {
}

variable "vpc_tfstate_bucket_key" {
}

variable "vpc_tfstate_bucket_region" {
}

#variable "tag_tfstate_bucket_name" {}
#variable "tag_tfstate_bucket_key" {}
#variable "tag_tfstate_bucket_region" {}

#variable "allowed_security_group" { type = "list" }
variable "cluster_instance_type" {
}

variable "gis_cluster_instance_type" {
}

variable "engineer_name" {
}

variable "owner_name" {
}

variable "cluster_name" {
}

variable "db_engine" {
}

variable "engine_version" {
}

variable "replica_count" {
}

variable "storage_encrypted" {
}

variable "apply_immediately" {
}

variable "monitoring_interval" {
}

#variable "master_username" {}
#variable "master_password" {}
variable "aurora_master_username_ssm_path" {
}

variable "aurora_master_password_ssm_path" {
}

variable "skip_final_snapshot" {
}

