#!/bin/bash

echo "Deploying Docker container..."
docker-compose down
docker-compose up -d
