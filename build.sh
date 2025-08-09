#!/bin/bash

set -e

BRANCH="${1:-dev}"  # default to dev if no argument
IMAGE_NAME="jprakash2306/e-commerce-react-app"
TAG="${BRANCH}-$(date +%Y%m%d%H%M%S)"

echo "🔨 Building Docker image for branch '$BRANCH': $IMAGE_NAME:$TAG"
docker build -t $IMAGE_NAME:$TAG .

echo "✅ Build complete."

# Optionally push image to Docker Hub
echo "📤 Pushing to Docker Hub..."
docker push $IMAGE_NAME:$TAG

echo "✅ Docker image pushed: $IMAGE_NAME:$TAG"
