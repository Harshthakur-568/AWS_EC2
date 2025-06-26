#!/bin/bash
set -e

# Pull the latest code
git pull origin main

# Build the Docker image
docker build -t my-webapp .

# Stop and remove any existing container
docker stop my-webapp || true
docker rm my-webapp || true

# Run the new container
docker run -d --name my-webapp -p 80:3000 my-webapp

echo "Deployment complete!"
