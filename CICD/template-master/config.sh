#!/usr/bin/env bash

set -e

print_usage_and_exit () {
    echo "Usage: ./config.sh [VALUE] --components [VALUE] [VALUE] [VALUE] [...] --vpc-statefile-path [VALUE] --directory [VALUE]"
    echo "--components : any or all of these: cassandra  docdb  efs  emr  msk; optional"
    echo "--vpc-statefile-path : VPC statefile key; optional" 
    echo "--directory : path relative to the current directory, e.g., \"../mytestcluster\"; required"
    exit 1
}

if [[ ${1} == "" ]]; then print_usage_and_exit; fi

deployment_name="${1}"
components=()
vpc_statefile_path=""
directory=""
while [[ $# -gt 1 ]]
do
    key="$1"
    case $key in
        --vpc-statefile-path)
        vpc_statefile_path=$2
        shift
        ;;
        --directory)
        directory=$2
        shift
        ;;
        --components)
            while (( "$#" >= 2 )) && ! [[ $2 = --* ]]; do
                components+=("$2")
                shift
            done
        ;;
        *)
        #echo Configure option \'$1\' not understood!
        #echo Use ./configure --help to see correct usage!
        #exit -1
        #break
        ;;
    esac
    shift
done

if [[ ${directory} == "" ]]; then
  print_usage_and_exit
fi

mkdir ${directory}
cp -r . ${directory}
pushd ${directory}

export current_path=$(pwd)
find . -type f -name 'terragrunt.hcl' | xargs sed -i -e 's/\[PATH_TO_EKS_FILES\]/'"${current_path////\\/}"'/g'

find . -type f -name 'terragrunt.hcl' | xargs sed -i -e 's/\[CLUSTER_NAME\]/'"${deployment_name}"'/g'

components+=("aurora")
components+=("eks")
components+=("iam")

pushd components
directories=( $(ls) )
if [[ !(" ${components[@]} " =~ " all ") ]]; then
  if [[ (" ${components[@]} " =~ " all_but_vpc ") ]]; then
    vpc_array_element=(vpc)
    components=( "${directories[@]/$vpc_array_element}" )
  fi
  for dir in "${directories[@]}"
  do
    if [[ !(" ${components[@]} " =~ " ${dir} ") ]]; then
      if [[ -d ${dir} ]]; then
        rm -rf ${dir}
        mkdir ${dir}
        cat <<EOF > ${dir}/backend.tf
terraform {
  backend "s3" {}
}
EOF
        cat <<EOF > ${dir}/terragrunt.hcl
include {
    path = find_in_parent_folders()
}
EOF
      fi
    fi
  done
else
  components=("${directories[@]}")
fi
popd

for component_name in "${components[@]}"; do
    if [[ ${component_name} != "" ]]; then
        find components -type f -name 'terragrunt.hcl' | xargs sed -i -e 's#.shared3/components/'"${component_name}"'#'"${deployment_name}"'/components/'"${component_name}"'#g'
    fi
done

if [[ ${vpc_statefile_path} != "" ]]; then
    find components -type f -name 'terragrunt.hcl' | xargs sed -i -e 's#phoenix/df14-test/.shared3/components/vpc/terraform.tfstate#'"${vpc_statefile_path}"'#g'
fi
rm -rf config.sh Jenkinsfile README.md setup.sh.ignore
echo ${directory}
popd
