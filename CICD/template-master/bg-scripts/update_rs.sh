#!/bin/bash

set -e

helpFunction()
{
   echo ""
   echo -e "\033[4mUsage:\033[0m bash $0 -r \"RecordSet\" -h \"zoneID\" -d \"DNSName\" -a \"AliasTArgetZoneID\""
   echo -e "\t-r : Entire name of the Record Set"
   echo -e "\t-h : HostedZone ID in which the record set you need to create/update"
   echo -e "\t-d : Alias Target DNS name (ELB)"
   echo -e "\t-a : Hosted Zone ID in which the DNSName (ELB) is existing"
   exit 1 # Exit script after printing help
}

while getopts "r:h:d:a:" opt
do
   case "$opt" in
      r ) RecordSet="$OPTARG" ;;
      h ) HostedZoneID="$OPTARG" ;;
      d ) AliasTargetDNS="$OPTARG" ;;
      a ) AliasHostedZoneID="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Print helpFunction in case parameters are empty
if [ -z "$RecordSet" ] || [ -z "$HostedZoneID" ] || [ -z "$AliasTargetDNS" ] || [ -z "$AliasHostedZoneID" ]
then
   echo "Some or all of the parameters are empty";
   helpFunction
fi

# Begin script in case all parameters are correct
echo "RecordSet: $RecordSet"
echo "HostedZoneID: $HostedZoneID"
echo "AliasTargetDNS: $AliasTargetDNS"
echo "AliasHostedZoneID: $AliasHostedZoneID"

cat > change-batch.json << EOF
{
  "Comment": "updating Alias Target",
  "Changes": [
    {
      "Action": "UPSERT",
      "ResourceRecordSet": {
        "Name": "$RecordSet",
        "Type": "A",
        "AliasTarget": {
          "HostedZoneId": "$AliasHostedZoneID",
          "DNSName": "$AliasTargetDNS",
          "EvaluateTargetHealth": false
        }
      }
    }
  ]
}
EOF

aws route53 change-resource-record-sets --hosted-zone-id "$HostedZoneID" --change-batch file://change-batch.json

rm change-batch.json
