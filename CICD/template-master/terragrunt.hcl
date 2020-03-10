remote_state {
  backend = "s3"
  config = {
    bucket         = "halliburton-terraform-state"
    key            = "phoenix/df14-test/[CLUSTER_NAME]/${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
