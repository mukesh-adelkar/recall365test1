dependencies {
  paths = ["../vpc"]
}
include {
  path = "${find_in_parent_folders()}"
}
terraform {
  source = "git::ssh://git@gitlab.com/Halliburton-Landmark/dsif/terraform/aws/iam.git//?ref=master"
} 

inputs = {
  region = "us-east-1"
  suffix = "[CLUSTER_NAME]"
  environment = "my_environment"
  override_ec2_iam_policy = "null"
  append_ec2_iam_policy = "null"
  additional_tags = {}
  do_use_tag_tfstate = "false"
  tag_tfstate_bucket_key = "null"
  tag_tfstate_bucket_name = "null"
  tag_tfstate_bucket_region = "null"
  do_use_prereqs_tfstate = "true"
  prereqs_tfstate_bucket_key = "phoenix/df14-test/.dev/components/prereqs/terraform.tfstate"
  prereqs_tfstate_bucket_name = "halliburton-terraform-state"
  prereqs_tfstate_bucket_region = "us-east-1"
  worker_group_count = "1"
  dsif_eks_bucket = "null"
  dsif_emr_bucket = "null"
  dsif_jupyter_bucket = "null"
  efs_iam_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Action": [
              "elasticfilesystem:DescribeFileSystems"
          ],
          "Resource": "*",
          "Effect": "Allow"
      }
  ]
}
EOF

  #### Example of custom IAM policy for installer
  custom_user_iam_policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
  {
    "Action": [
      "ec2:Describe*"
    ],
    "Effect": "Allow",
    "Resource": [
      "*"
    ]
  }
]
}
EOF
}
