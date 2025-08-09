#!/bin/bash

set -e

BRANCH="$1"

if [[ -z "$BRANCH" ]]; then
  echo "Error: Branch name argument required (dev or main)"
  exit 1
fi

TIMESTAMP=$(date +%Y%m%d%H%M%S)

if [[ "$BRANCH" == "dev" ]]; then
  IMAGE_NAME="jprakash2306/e-commerce-react-dev"
elif [[ "$BRANCH" == "main" ]]; then
  IMAGE_NAME="jprakash2306/e-commerce-react-prod"
else
  echo "Error: Unsupported branch '$BRANCH'. Use dev or main."
  exit 1
fi

TAG="${BRANCH}-${TIMESTAMP}"

echo "🔨 Building Docker image $IMAGE_NAME:$TAG for branch $BRANCH"

# Build the React app docker image (make sure Dockerfile builds with tag e-commerce-react-app:latest)
docker build -t e-commerce-react-app:latest .

# Tag the image with your Docker Hub repo and branch tag
docker tag e-commerce-react-app:latest $IMAGE_NAME:$TAG

# Push the image to Docker Hub
echo "📤 Pushing image $IMAGE_NAME:$TAG to Docker Hub"
docker push $IMAGE_NAME:$TAG

echo "✅ Build and push completed for $IMAGE_NAME:$TAG"
