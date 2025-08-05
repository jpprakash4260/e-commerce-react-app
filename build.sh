#!/bin/bash

IMAGE_NAME="/dev"

echo "Building Docker image..."
docker build -t $IMAGE_NAME:latest .
