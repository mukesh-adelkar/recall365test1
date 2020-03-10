#!/bin/bash

set -e

helpFunction()
{
   echo ""
   echo -e "\033[4mUsage:\033[0m bash $0 -d \"DisassociateHostedZoneID\" -a \"AssociateZoneID\" -v \"VpcID\" -r \"VpcRegion\""
   echo -e "\t-d : Hosted Zone ID from which you want to disassociate the VPC "
   echo -e "\t-a : HostedZone ID to which you want to associate the VPC"
   echo -e "\t-v : VPC ID you want to associate/disassociate"
   echo -e "\t-r : Region in which the VPC is existing"
   exit 1 # Exit script after printing help
}

while getopts "d:a:v:r:" opt
do
   case "$opt" in
      d ) DisassociateHostedZoneID="$OPTARG" ;;
      a ) AssociateZoneID="$OPTARG" ;;
      v ) VpcID="$OPTARG" ;;
      r ) VpcRegion="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Print helpFunction in case parameters are empty
if [ -z "$DisassociateHostedZoneID" ] || [ -z "$AssociateZoneID" ] || [ -z "$VpcID" ] || [ -z "$VpcRegion" ]
then
   echo "Some or all of the parameters are empty";
   helpFunction
fi

##Disassociating VPC from Hosted Zone
aws route53 get-hosted-zone --id  "$DisassociateHostedZoneID" | grep -q $VpcID
if [[ $? -eq 0 ]]; then
  vpc_count=$(aws route53 get-hosted-zone --id "$DisassociateHostedZoneID" | grep "VPCId" | wc -l)
  if [[ "$vpc_count" -gt 1 ]]; then
    aws route53 disassociate-vpc-from-hosted-zone --hosted-zone-id "$DisassociateHostedZoneID" --vpc VPCRegion=$VpcRegion,VPCId=$VpcID
    echo "VPC $VpcID is disassociated"
  else
    echo "VPC $VpcID will not be disassociated, because you must keep atleast one association"
  fi
else
  echo "VPC $VpcID is not associated"
fi


## Associate VPC to HostedZone

aws route53 get-hosted-zone --id "$AssociateZoneID" | grep -q $VpcID
if [[ ! $? -eq 0 ]]; then
  aws route53 associate-vpc-with-hosted-zone --hosted-zone-id "$AssociateZoneID" --vpc VPCRegion=$VpcRegion,VPCId=$VpcID
else
  echo "VPC $VpcID is already associated to hosted zone"
fi
