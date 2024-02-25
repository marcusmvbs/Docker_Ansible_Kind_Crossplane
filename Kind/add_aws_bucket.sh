# Crossplane pod creation time
# ./add..sh

# Provider creation
kubectl apply -f ./charts/dev/aws/provider.yaml

# Secret and Provider Config
kubectl create secret generic aws-creds -n crossplane-ns --from-file=creds=./charts/dev/aws/creds.txt
kubectl create -f ./charts/dev/aws/providerconfig.yaml
rm ./charts/dev/aws/creds.txt

# Provider Resource - S3 Bucket
kubectl apply -f ./charts/dev/aws/s3.yaml