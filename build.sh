#!/bin/bash

# Stop on first error
set -e

# Define your image name
IMAGE_NAME="e-commerce-react-app"

echo "🔨 Building Docker image: $IMAGE_NAME"
docker build -t $IMAGE_NAME:latest .

echo "✅ Build complete."
