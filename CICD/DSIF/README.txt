helm install distplat-helm/enterprise-search --version 0.0.7  --name enterprise-search --set global.cluster.hosts="recallng1.recallng1.landmarksoftware.io" --namespace=ic-system

helm install distplat-helm/wfservices  --version 1.0.7  --name wf-services --set global.cluster.hosts="recallng1.recallng1.landmarksoftware.io" --set global.extraEnv.DSIS_SECURITY_SERVER_URL="https://dssecurity.recallng1.recallng1.landmarksoftware.io/auth" --namespace=wf-system

