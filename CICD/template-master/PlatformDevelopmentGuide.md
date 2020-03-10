# Platform Development Guide

## AWS Cluster Creation

1. Clone the live-repo, e.g., by running the command `git clone git@gitlab.com:Halliburton-Landmark/dsif/live/aws/template` 
2. Navigate to the root of the repo and run the command `./config.sh [DEPLOYMENT_NAME] --components [VALUE] [VALUE] [VALUE] [...] --directory [DIRECTORY_NAME]`. The `--components` option is optional, and Aurora and EKS are implicitly included and don't need to be listed. Available components include "vpc", "cassandra", "docdb", "efs", "emr", and "msk". Sample command for setting up the directory to deploy Aurora followed by EKS: `./config.sh mycluster --directory ../mycluster`
3. Navigate to the directory specified in step 2.
4. To have the EKS deployment reference state-files of pre-existing deployments of your choosing, you need to manually change the appropriate S3 statefile paths in the EKS `terraform.tfstate` file.
5. Run `terragrunt apply-all` in the root of the generated directory to kick-off the build of all components in the right order. Alternatively, you may successively run `terragrunt apply` in each component’s directory, but you must make sure to build VPC first and EKS last.
6. To test the deployment, SSH into the bastion node, navigate to the directory `/home/centos/script/test` and run the command `./test-all.sh ${clusterName}.landmarksoftware.io`. Here's a listing of other test scripts you can run: https://git.openearth.community/distplat/phoenix-op/blob/master/pipelines/aws/df14_eks_create.groovy#L121

## Image Release Process for AWS EKS deployment:

To generate and use a bastion image:

1. Create a Jenkins pipeline that references this `Jenkinsfile`: https://gitlab.com/Halliburton-Landmark/dsif/terraform/base/blob/master/bastion_image_generator/Jenkinsfile. The Jenkins slave on which the pipeline is to be run must have the appropropriate AWS EC2 permissions. Here is a sample pipeline: http://jenkins.distop2.landmarksoftware.io/job/eks_bastion_image_generator/
2. Click "Build with Parameters".
3. Set the parameters. Specify the AWS accounts with which the generated image is to be shared and the source image ID. Set the factory-parameter to "rd" and the engineer-parameter to your name.
4. Click "Build". The image should be generated after about 15 minutes.
5. The image ID will be output in a format that looks like this:

```
==> Builds finished. The artifacts of successful builds are:
--> amazon-ebs: AMIs were created:
us-east-1: ami-0f65706a374d73bab
```

6. Go to the EKS `terragrunt.hcl` (e.g., https://gitlab.com/Halliburton-Landmark/dsif/live/aws/template/blob/master/components/eks/terragrunt.hcl#L40) file in your live-repo and replace the value of the Terraform variable `bastion_ami` with the newly-generated image-ID.
7. You may now create an EKS cluster that uses the newly-generated bastion image.

To generate and use an EKS-node image, go through the bastion-image generation process, but with this `Jenkinsfile`: https://gitlab.com/Halliburton-Landmark/dsif/terraform/base/blob/master/worker_image_generator/Jenkinsfile

## Image Release Process for Azure AKS deployment:

To generate and use a bastion image:

1. Create a Jenkins pipeline that references this `Jenkinsfile`: https://gitlab.com/Halliburton-Landmark/dsif/terraform/base/blob/master/bastion_image_generator/azure/Jenkinsfile. Here is a sample pipeline: http://jenkins.distop2.landmarksoftware.io/job/eks_bastion_image_generator/
2. Click "Build with Parameters".
3. Set the parameters. Make sure that `AzClientId`, `AzClientSecretStorage`, `AzSubscriptionId`, `AzTenantId` all have valid values so that the Jenkins slave has the proper Azure permissions.
4. Click "Build". The image should be generated after about 45 minutes.
5. The image ID will be output in a format that looks like this:

```
==> Builds finished. The artifacts of successful builds are:
--> azure-arm: Azure.ResourceManagement.VMImage:

OSType: Linux
ManagedImageResourceGroupName: ImagesResourceGroup
ManagedImageName: bastion-rd-dev-centos7.6-202001031938
ManagedImageId: /subscriptions/d0caf267-2a0f-4f85-b014-f370d0e4b3ae/resourceGroups/ImagesResourceGroup/providers/Microsoft.Compute/images/bastion-rd-dev-centos7.6-202001031938
ManagedImageLocation: eastus
ManagedImageSharedImageGalleryId: /subscriptions/d0caf267-2a0f-4f85-b014-f370d0e4b3ae/resourceGroups/GalleriesResourceGroup/providers/Microsoft.Compute/galleries/DevTeamGallery/images/Bastion/versions/2020.0103.1938
```

6. Go to the EKS `terragrunt.hcl` (e.g., https://gitlab.com/Halliburton-Landmark/dsif/live/azure/template/blob/master/components/aks/terragrunt.hcl#L106) file in your live-repo and ensure that these 3 Terraform values have been appropriately set: 

```
shared_image_name                = "Bastion"
shared_image_gallery_name        = "DevTeamGallery"
shared_image_resource_group_name = "GalleriesResourceGroup"
```

7. You may now create an AKS cluster that uses the newly-generated bastion image.
