#!/bin/bash

# Set common variables
RELEASE_NAME="shopedge"
NAMESPACE="shopedge"

# Function to deploy to EKS
deploy_eks() {
    echo "Deploying to EKS..."
    aws eks update-kubeconfig --region us-east-1 --name shopedge-cluster
    
    # Create namespace if not exists
    kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -
    
    # Deploy with Helm
    helm upgrade --install $RELEASE_NAME ./shopedge-chart \
        --namespace $NAMESPACE \
        --set image.repository=$ECR_REPO \
        --set image.tag=$VERSION
}





# Deploy to aws clouds
deploy_eks


echo "Deployment completed to all aws cloud platforms!"