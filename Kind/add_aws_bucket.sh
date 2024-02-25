# Crossplane pod creation time
sleep 90

# Provider creation
kubectl apply -f ./charts/dev/aws/provider.yaml
sleep 170

# Secret and Provider Config
kubectl create secret generic aws-creds -n crossplane-ns --from-file=creds=../.creds.txt
kubectl create -f ./charts/dev/aws/providerconfig.yaml
sleep 10
rm ../.creds.txt

# Provider Resource - S3 Bucket
kubectl apply -f ./charts/dev/aws/s3.yaml