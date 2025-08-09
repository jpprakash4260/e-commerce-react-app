#!/bin/bash

set -e

BRANCH="$1"

if [[ -z "$BRANCH" ]]; then
  echo "Error: Branch name argument required (dev or main)"
  exit 1
fi

if [[ "$BRANCH" == "dev" ]]; then
  IMAGE_NAME="jprakash2306/e-commerce-react-dev"
elif [[ "$BRANCH" == "main" ]]; then
  IMAGE_NAME="jprakash2306/e-commerce-react-prod"
else
  echo "Error: Unsupported branch '$BRANCH'. Use dev or main."
  exit 1
fi

echo "🔨 Building Docker image $IMAGE_NAME:latest for branch $BRANCH"

docker build -t e-commerce-react-app:latest .

docker tag e-commerce-react-app:latest $IMAGE_NAME:latest

docker push $IMAGE_NAME:latest

echo "✅ Build and push completed for $IMAGE_NAME:latest"
