#!/bin/bash

set -e

BRANCH="${1:-dev}"  # default to dev if no argument
IMAGE_NAME="jprakash2306/e-commerce-react-app"

# Find latest image tag for that branch (simplified approach using docker image ls)
LATEST_TAG=$(docker images --format "{{.Repository}}:{{.Tag}}" | grep "^$IMAGE_NAME:$BRANCH" | sort | tail -n1)

if [ -z "$LATEST_TAG" ]; then
  echo "❌ No image found for branch $BRANCH. Please build first."
  exit 1
fi

CONTAINER_NAME="ecommerce-${BRANCH}"

# Select port based on branch
if [ "$BRANCH" == "dev" ]; then
  HOST_PORT=81
elif [ "$BRANCH" == "master" ]; then
  HOST_PORT=80
else
  echo "❌ Unsupported branch: $BRANCH"
  exit 1
fi

echo "📦 Stopping old container $CONTAINER_NAME (if any)..."
docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

echo "🚀 Deploying container $CONTAINER_NAME with image $LATEST_TAG on port $HOST_PORT..."

docker run -d -p $HOST_PORT:80 --name $CONTAINER_NAME $LATEST_TAG

echo "✅ Deployed successfully at http://<your-server-ip>:$HOST_PORT"
