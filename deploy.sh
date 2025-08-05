#!/bin/bash

# Stop on first error
set -e

echo "📦 Stopping old container (if any)..."
docker-compose down || true

echo "🚀 Deploying updated container..."
docker-compose up -d

echo "✅ Deployed successfully on port 80."
