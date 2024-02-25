# Crossplane pod creation time
sleep 90

# Provider creation
kubectl apply -f ./charts/dev/aws/provider.yaml
sleep 170

# Secret and Provider Config
kubectl create secret generic aws-creds -n crossplane-ns --from-file=creds=./charts/dev/aws/.credentials.txt
kubectl create -f ./charts/dev/aws/providerconfig.yaml
sleep 10
rm ./charts/dev/aws/credentials.txt

# Provider Resource - S3 Bucket
kubectl apply -f ./charts/dev/aws/s3.yaml