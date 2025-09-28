#!/bin/bash

# Set variables
APP_NAME="shopedge"
VERSION="1.0.0"
REGISTRIES=("aws") # "azure" "gcp"

# AWS ECR Configuration
AWS_ACCOUNT_ID="150845227320" 
AWS_REGION="us-east-1"
ECR_REPO="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$APP_NAME"



# Build the image
echo "Building Docker image..."
docker build -t $APP_NAME:$VERSION .

# Tag and push to AWS ECR
echo "Pushing to AWS ECR..."
#aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REPO
docker tag $APP_NAME:$VERSION $ECR_REPO:$VERSION
docker push $ECR_REPO:$VERSION



echo "Images pushed to  aws registry!"