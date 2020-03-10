provider "aws" {
  version = "= 2.48.0"
  region = var.region
}

resource "aws_db_parameter_group" "aurora_db_postgres96_parameter_group" {
  name        = "${var.cluster_name}-parameter-group"
  family      = "aurora-postgresql9.6"
  description = "${var.cluster_name}-parameter-group"
}

resource "aws_rds_cluster_parameter_group" "aurora_cluster_postgres96_parameter_group" {
  name        = "${var.cluster_name}-cluster-parameter-group"
  family      = "aurora-postgresql9.6"
  description = "${var.cluster_name}-cluster-parameter-group"
}

locals {
  vpc_id = var.vpc_id != "" ? var.vpc_id : data.terraform_remote_state.vpc.outputs.vpc_id
  private_subnets = split(
    ",",
    length(var.private_subnets) != 0 ? join(",", var.private_subnets) : join(",", data.terraform_remote_state.vpc.outputs.private_subnets),
  )
}

module "db" {
  version             = "2.3.0"
  source              = "terraform-aws-modules/rds-aurora/aws"
  name                = var.cluster_name
  engine              = var.db_engine
  engine_version      = var.engine_version
  vpc_id              = local.vpc_id
  subnets             = local.private_subnets
  replica_count       = var.replica_count
  skip_final_snapshot = var.skip_final_snapshot

  #  allowed_security_groups         = ["${data.aws_security_group.eks_security_group.id}"]
  instance_type                   = var.cluster_instance_type
  storage_encrypted               = var.storage_encrypted
  apply_immediately               = var.apply_immediately
  monitoring_interval             = var.monitoring_interval
  db_parameter_group_name         = aws_db_parameter_group.aurora_db_postgres96_parameter_group.id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora_cluster_postgres96_parameter_group.id
  username                        = data.aws_ssm_parameter.aurora_master_username.value
  password                        = data.aws_ssm_parameter.aurora_master_password.value

#  tags = data.terraform_remote_state.tags.outputs.tags
  tags = {
    Owner    = var.owner_name
    Engineer = var.engineer_name
    Project  = var.cluster_name
  }
}

#resource "aws_rds_cluster_instance" "gis_instance" {
#  count              = 1
#  identifier         = "${var.cluster_name}-gis"
#  cluster_identifier = "${module.db.this_rds_cluster_id}"
#  instance_class     = "${var.gis_cluster_instance_type}"
#  engine             = "${var.db_engine}"
#  engine_version     = "${var.engine_version}"
#}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = var.vpc_tfstate_bucket_name
    key    = var.vpc_tfstate_bucket_key
    region = var.vpc_tfstate_bucket_region
  }

  defaults = {
    vpc_id          = ""
    private_subnets = []
  }
}

#data "terraform_remote_state" "tags" {
#  backend = "s3"
#
#  config = {
#    bucket = var.tag_tfstate_bucket_name
#    key    = var.tag_tfstate_bucket_key
#    region = var.tag_tfstate_bucket_region
#  }
#}


data "aws_ssm_parameter" "aurora_master_username" {
  name = var.aurora_master_username_ssm_path
}

data "aws_ssm_parameter" "aurora_master_password" {
  name = var.aurora_master_password_ssm_path
}

data "http" "terraform_host_ip" {
  url = "http://169.254.169.254/latest/meta-data/local-ipv4"
}

data "http" "terraform_host_public_ip" {
  url = "http://ipecho.net/plain"
}

resource "aws_security_group_rule" "allow_bootstrap_traffic_to_aurora" {
  security_group_id = module.db.this_security_group_id
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = ["${data.http.terraform_host_ip.body}/32", "${trimspace(data.http.terraform_host_public_ip.body)}/32"]
}

