# Distributed Platform Infrastructure live configuration

## Introduction

This repository holds the live configuration details of the df14 disributed platform configuration. The motivations for maintiaing the live infrastructure 
are gitops and terragrunt

### Terragrunt
Terragrunt is a thin wrapper over terraform and provides extra tools for keeping teraform configurations DRY, working with multiple terraform modules

As can be seen in the below tree, the components of an infrastructure can be defined via the variables in the respective directory and 
and accompanied setup.sh file to abstract plain teragrunt command.


```
├── components
│   ├── aurora
│   │   ├── setup.sh
│   │   └── terragrunt.hcl
│   ├── eks
│   │   ├── setup.sh
│   │   └── terragrunt.hcl
│   └── vpc
│       ├── setup.sh
│       └── terragrunt.hcl
├── README.md
└── terragrunt.hcl

```

A sample terragrunt.hcl will contain something like below

```hcl-terraform
terragrunt = {
  dependencies {
    paths = ["../vpc"]
  }
   include {
    path = "${find_in_parent_folders()}"
  }
  terraform {
    source = "git::ssh://git@gitlab.com/Halliburton-Landmark/dsif/terraform/aws/eks.git//?ref=master"
  }
}

cluster_name = "df14-live-aurora"
engineer_name = "Ujjwal Singh"
owner_name = "Wei Chiu"
vpc_id = "vpc-xxxxxxxxxxx"
private_subnets = ["subnet-yyyyyyyyyyy", "subnet-zzzzzzzzzzzzzzz"]
instance_type = "db.r4.large"

```
This allows below flexibilities

* Specifiying custom tags/branches/repos of different repositories which hold
the actual terraform source code of infrastructure

* Passing the variable parameter to the actual terraform code.

* Specifying the dependency on the different modules which are glued together
 
* Allows automatic segregation of the state files in the backend based on the interpolation
syntax `"${find_in_parent_folders()}"`

* A relaxed interpolation needed for managing terraform variables

* The terraform root source code can be instructed to read from s3 buckets the existing state of the infrastructure.

### TODO
One command installation of full cluster
Jenkins to use the live infrastructure code for platform deployment
Jenkins for service deployment in the EKS cluster