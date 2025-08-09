#!/bin/bash

set -e

BRANCH="$1"

if [[ -z "$BRANCH" ]]; then
  echo "Error: Branch name argument required (dev or main)"
  exit 1
fi

if [[ "$BRANCH" == "dev" ]]; then
  IMAGE_NAME="jprakash2306/e-commerce-react-dev"
  DEPLOY_PORT=81
  CONTAINER_NAME="reactapp-dev"
elif [[ "$BRANCH" == "main" ]]; then
  IMAGE_NAME="jprakash2306/e-commerce-react-prod"
  DEPLOY_PORT=80
  CONTAINER_NAME="reactapp-prod"
else
  echo "Error: Unsupported branch '$BRANCH'. Use dev or main."
  exit 1
fi

echo "🛑 Stopping and removing old container $CONTAINER_NAME if exists..."
docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

echo "🚀 Deploying container $CONTAINER_NAME with image $IMAGE_NAME:latest on port $DEPLOY_PORT..."
docker run -d -p $DEPLOY_PORT:80 --name $CONTAINER_NAME $IMAGE_NAME:latest

echo "✅ Deployment of $CONTAINER_NAME completed."
