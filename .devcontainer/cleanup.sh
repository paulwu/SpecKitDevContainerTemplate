#!/bin/bash
# Clear DevContainer cache and containers

echo "🧹 Cleaning up DevContainer cache and containers..."

# Stop and remove any running containers with the project label
echo "Stopping containers..."
docker ps -q --filter "label=devcontainer.local_folder=c:\GitHub_paulwu\SpecKitTest" | xargs -r docker stop

echo "Removing containers..."
docker ps -aq --filter "label=devcontainer.local_folder=c:\GitHub_paulwu\SpecKitTest" | xargs -r docker rm

# Remove images built for this project
echo "Removing images..."
docker images -q --filter "label=devcontainer.local_folder=c:\GitHub_paulwu\SpecKitTest" | xargs -r docker rmi

# Clean up build cache
echo "Cleaning build cache..."
docker builder prune -f

# Clean up volumes (optional - be careful with this)
echo "Cleaning up unused volumes..."
docker volume prune -f

echo "✅ Cleanup complete!"
echo ""
echo "Now try rebuilding your DevContainer:"
echo "1. Press Ctrl+Shift+P"
echo "2. Select 'Dev Containers: Rebuild Container'"